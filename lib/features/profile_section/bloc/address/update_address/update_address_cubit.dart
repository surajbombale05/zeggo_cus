import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/main.dart';

part 'update_address_state.dart';

class UpdateAddressCubit extends Cubit<UpdateAddressState> {
  UpdateAddressCubit() : super(UpdateAddressInitial());

  updateAdrress({
    String? addType,
    String? fullName,
    String? phoneNo,
    String? fullAddress,
    String? city,
    String? zipCode,
    bool? isPrimary,
    String? userId,
    String? lat,
    String? long,
    required String addressId,
  }) async {
    try {
      emit(UpdateAddressLoadingState());
      final resp = await repository.sendRequest.put(
        "${AppString.baseUrl}/api/zeggo/user-addresses/$addressId",
        data: {
          "add_type": addType,
          "full_name": fullName,
          "phone_no": phoneNo,
          "full_address": fullAddress,
          "city": city,
          "zip_code": zipCode,
          "is_primary": isPrimary,
          "user_id": userId,
          "lat": lat,
          "long": long,
        },
      );

      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(UpdateAddressLoadedState());
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(UpdateAddressErrorState(result["message"]));
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

      emit(UpdateAddressErrorState(errorMessage));
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(UpdateAddressErrorState(e.toString()));
    }
  }
}
