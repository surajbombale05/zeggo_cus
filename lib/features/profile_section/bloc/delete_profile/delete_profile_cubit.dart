import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/main.dart';

part 'delete_profile_state.dart';

class DeleteProfileCubit extends Cubit<DeleteProfileState> {
  DeleteProfileCubit() : super(DeleteProfileInitial());

  deleteProfile() async {
    try {
      emit(DeleteProfileLoadingState());
      final resp = await repository.sendRequest.delete("${AppString.baseUrl}/api/zeggo/users/$userId");
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(DeleteProfileLoadedState());
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(DeleteProfileErrorState(result["message"]));
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

      emit(DeleteProfileErrorState(errorMessage));
    }  catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(DeleteProfileErrorState(e.toString()));
    }
  }
}
