import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/main.dart' show repository;

part 'get_nearby_supplier_state.dart';

class GetNearbySupplierCubit extends Cubit<GetNearbySupplierState> {
  GetNearbySupplierCubit() : super(GetNearbySupplierInitial());

  getNearBySupplier({required String orderId}) async {
    try {
      emit(GetNearbySupplierLoadingState());

      final resp = await repository.sendRequest.get(
        "${AppString.baseUrl}/api/zeggo/orders/$orderId/nearby-suppliers",
      );
      final result = resp.data;
      log("---- GetNearbySupplierCubit $result");
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        if (result["status"] == true) {
          emit(GetNearbySupplierLoadedState());
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetNearbySupplierErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetNearbySupplierErrorState(e.toString()));
    }
  }
}
