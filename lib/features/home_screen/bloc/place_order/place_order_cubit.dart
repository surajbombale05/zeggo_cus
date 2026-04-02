import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/place_order/place_order_model.dart';
import 'package:zeggo_cus/main.dart';
import 'package:zeggo_cus/utils/storage/cart_item.dart';
import 'package:zeggo_cus/utils/storage/storage.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());

  Future<PlaceOrderModel?> placeOrder({
    required String addressId,
    required List<CartItem> cartItems,
    required String paymentMethod,
  }) async {
    try {
      emit(PlaceOrderLoadingState());
      final userId = await LocalStorageUtils.getUserId();

      if (userId == null) {
        emit(PlaceOrderErrorState("User not logged in"));
        return null;
      }
      final items = prepareItems(cartItems);

      final url = "${AppString.baseUrl}/api/zeggo/orders/create-order";

      final body = {
        "user_id": userId,
        "address_id": addressId,
        "delivery_fee": "0",
        "items": items,
        "payment_type": paymentMethod,
      };

      logCurl(url: url, data: body, method: "POST");

      final resp = await repository.sendRequest.post("${AppString.baseUrl}/api/zeggo/orders/create-order", data: body);
      final result = resp.data;
      log("---- PlaceOrderCubit $result");
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        if (result["status"] == true) {
          final model = PlaceOrderModel.fromJson(result);
          emit(PlaceOrderLoadedState(model));
          return model;
        } else {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(PlaceOrderErrorState(result["message"]));
          return null;
        }
      }
      return null;
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

      emit(PlaceOrderErrorState(errorMessage));
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(PlaceOrderErrorState(e.toString()));
      return null;
    }
    return null;
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

  void logCurl({required String url, required Map<String, dynamic> data, required String method}) {
    final buffer = StringBuffer();

    buffer.write("curl -X $method '$url' \\\n");

    buffer.write("-H 'Content-Type: application/json' \\\n");

    buffer.write("-d '${jsonEncode(data)}'");

    log("CURL => \n${buffer.toString()}");
  }
}
