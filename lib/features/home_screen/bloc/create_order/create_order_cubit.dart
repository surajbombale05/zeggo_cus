import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/create_order/create_order_model.dart';
import 'package:zeggo_cus/main.dart';
part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit() : super(CreateOrderInitial());

  createOrder({required String amount}) async {
    try {
      emit(CreateOrderLoadingState());

      final resp = await repository.sendRequest.post(
        "${AppString.baseUrl}/api/zeggo/razorpay/create",
        data: {"amount": amount},
      );
      final result = resp.data;
      log("---- CreateOrderCubit $result");
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        if (result["status"] == true) {
          emit(CreateOrderLoadedState(CreateOrderModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(CreateOrderErrorState(result["message"]));
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

      emit(CreateOrderErrorState(errorMessage));
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(CreateOrderErrorState(e.toString()));
    }
  }
}
