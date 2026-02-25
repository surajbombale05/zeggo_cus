import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/auth/bloc/verify_otp/verify_otp_model.dart';
import 'package:zeggo_cus/main.dart';

part 'verify_otp_state.dart';

class VerifyOtpCubit extends Cubit<VerifyOtpState> {
  VerifyOtpCubit() : super(VerifyOtpInitial());

  verifyOtp(String mobileNumber, String otp, String deviceId, String deviceToken) async {
    try {
      emit(VerifyOtpLoadingState());
      final resp = await repository.sendRequest.post(
        "${AppString.baseUrl}/api/zeggo/users/verify-otp",
        data: {"phone_no": mobileNumber, "otp": otp, "device_id": deviceId, "device_token": deviceToken},
        options: Options(validateStatus: (status) => status != null && status < 500),
      );
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      log("------ $result");
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(VerifyOtpLoadedState(VerifyOtpModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(VerifyOtpErrorState(result["message"]));
        }
      } else {
        emit(VerifyOtpErrorState(result["message"]));
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(VerifyOtpErrorState(e.toString()));
    }
  }
}
