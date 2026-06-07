import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/main.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit() : super(UpdateProfileInitial());

  updateProfile({
    String? mobileNumber,
    String? name,
    String? email,
    File? profilePicture,
    bool? firstTimeUser,
    x,
  }) async {
    try {
      emit(UpdateProfileLoadingState());
      FormData formData = FormData.fromMap({
        "phone_no": mobileNumber,
        "name": name,
        "email": email,
        // "referral_code": referralCode,
        "first_time_user": firstTimeUser == true ? "1" : "0",
      });

      // ✅ Add profile image if exists
      if (profilePicture != null) {
        final mimeType = lookupMimeType(profilePicture.path) ?? "image/jpeg";
        final typeSplit = mimeType.split("/");

        formData.files.add(
          MapEntry(
            "profile_picture", // <-- backend key
            await MultipartFile.fromFile(
              profilePicture.path,
              filename: profilePicture.path.split('/').last,
              contentType: MediaType(typeSplit[0], typeSplit[1]),
            ),
          ),
        );
      }

      final resp = await repository.sendRequest.put(
        "${AppString.baseUrl}/api/zeggo/users/$userId",
        data: formData,
        options: Options(headers: {"Content-Type": "multipart/form-data"}),
      );
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        if (result["status"] == true) {
          emit(UpdateProfileLoadedState());
        } else if (result["status"] == false) {
          log(
            "Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}",
          );
          emit(UpdateProfileErrorState(result["message"]));
        }
      }
    } on DioException catch (e) {
      String errorMessage = "Something went wrong";

      if (e.response != null) {
        final data = e.response?.data;

        if (data is Map && data['message'] != null) {
          errorMessage = data['message'];
        } else {
          errorMessage = "Server error: ${e.response?.statusCode}";
        }
      } else {
        errorMessage = "No Internet Connection";
      }

      emit(UpdateProfileErrorState(errorMessage));
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(UpdateProfileErrorState(e.toString()));
    }
  }
}
