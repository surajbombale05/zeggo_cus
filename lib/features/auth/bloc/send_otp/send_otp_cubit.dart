import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/auth/bloc/send_otp/send_otp_model.dart';
import 'package:zeggo_cus/main.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit() : super(SendOtpInitial());

  sendOtp(String mobileNumber) async {
  try {
    log("📤 Sending OTP to: $mobileNumber");

    emit(SendOtpLoadingState());

    final resp = await repository.sendRequest.post(
      "${AppString.baseUrl}/api/zeggo/users/send-otp",
      data: {"phone_no": mobileNumber},
    );

    log("📥 Response Status: ${resp.statusCode}");
    log("📥 Response Data: ${resp.data}");

    final result = resp.data;

    if (resp.statusCode == 200) {
      if (result["status"] == true) {
        log("✅ OTP Sent Successfully");
        emit(SendOtpLoadedState(SendOtpModel.fromJson(result)));
      } else {
        log("❌ API Error: ${result["message"]}");
        emit(SendOtpErrorState(result["message"]));
      }
    } else {
      log("❌ Unexpected Status Code: ${resp.statusCode}");
      emit(SendOtpErrorState("Something went wrong"));
    }

  } catch (e, stk) {
    log("🔥 Exception Occurred: $e");
    log("🔥 StackTrace: $stk");
    emit(SendOtpErrorState("Network Error"));
  }
}
}
