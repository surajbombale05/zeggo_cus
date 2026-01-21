import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/auth/bloc/send_otp/send_otp_model.dart';
import 'package:zeggo_cus/main.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit() : super(SendOtpInitial());

  sendOtp(String mobileNumber) async {
    try {
      emit(SendOtpLoadingState());
      final resp = await repository.sendRequest.post(
        "${AppString.baseUrl}/api/zeggo/users/send-otp",
        data: {"phone_no": mobileNumber},
      );
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(SendOtpLoadedState(SendOtpModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(SendOtpErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(SendOtpErrorState(e.toString()));
    }
  }
}
