import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/place_order/place_order_model.dart';
import 'package:zeggo_cus/main.dart';
import 'package:zeggo_cus/utils/storage/cart_item.dart';
import 'package:zeggo_cus/utils/storage/storage.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());

  placeOrder({required String addressId, required List<CartItem> cartItems, required String paymentMethod}) async {
    try {
      emit(PlaceOrderLoadingState());
      final userId = await LocalStorageUtils.getUserId();

      if (userId == null) {
        emit(PlaceOrderErrorState("User not logged in"));
        return;
      }
      final items = prepareItems(cartItems);

      final resp = await repository.sendRequest.post(
        "${AppString.baseUrl}/api/zeggo/orders/create-order",
        data: {
          "user_id": userId,
          "address_id": addressId,
          "delivery_fee": "0",
          "items": items,
          "payment_type": paymentMethod,
        },
      );
      final result = resp.data;
      log("---- PlaceOrderCubit $result");
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        if (result["status"] == true) {
          emit(PlaceOrderLoadedState(PlaceOrderModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(PlaceOrderErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(PlaceOrderErrorState(e.toString()));
    }
  }

  List<Map<String, dynamic>> prepareItems(List<CartItem> cartItems) {
    final Map<String, int> merged = {};

    for (var item in cartItems) {
      merged.update(item.productId, (value) => value + item.quantity, ifAbsent: () => item.quantity);
    }

    return merged.entries.map((e) {
      return {"product_id": e.key, "quantity": e.value};
    }).toList();
  }
}
