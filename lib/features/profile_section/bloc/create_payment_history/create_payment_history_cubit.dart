import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/main.dart';

part 'create_payment_history_state.dart';

class CreatePaymentHistoryCubit extends Cubit<CreatePaymentHistoryState> {
  CreatePaymentHistoryCubit() : super(CreatePaymentHistoryInitial());

  createPaymentHistory({required String orderId, required String paymentOrderId, required String amount}) async {
    try {
      emit(CreatePaymentHistoryLoadingState());
      final resp = await repository.sendRequest.post(
        "${AppString.baseUrl}/api/zeggo/payment-history/create",
        data: {
          "user_id": userId,
          "order_id": orderId,
          "payment_order_id": paymentOrderId,
          "amount": amount,
          "type": "order_payment",
          "status": "completed",
          "payment_method": "online",
        },
      );

      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        if (result["status"] == true) {
          emit(CreatePaymentHistoryLoadedState());
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(CreatePaymentHistoryErrorState(result["message"]));
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

      emit(CreatePaymentHistoryErrorState(errorMessage));
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(CreatePaymentHistoryErrorState(e.toString()));
    }
  }
}
