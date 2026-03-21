import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/profile_section/bloc/get_order_by_id/get_order_by_id_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_order_by_id_state.dart';

class GetOrderByIdCubit extends Cubit<GetOrderByIdState> {
  GetOrderByIdCubit() : super(GetOrderByIdInitial());

  getOrderById(String orderId) async {
    try {
      emit(GetOrderByIdLoadingState());
      final resp = await repository.sendRequest.get("${AppString.baseUrl}/api/zeggo/orders/$orderId");
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetOrderByIdLoadedState(GetOrderByIdModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetOrderByIdErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetOrderByIdErrorState(e.toString()));
    }
  }
}
