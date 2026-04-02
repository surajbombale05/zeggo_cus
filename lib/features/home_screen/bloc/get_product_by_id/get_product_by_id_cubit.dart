import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_product_by_id/get_product_by_id_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_product_by_id_state.dart';

class GetProductByIdCubit extends Cubit<GetProductByIdState> {
  GetProductByIdCubit() : super(GetProductByIdInitial());

  getProductById(String productId) async {
    try {
      emit(GetProductByIdLoadingState());
      final resp = await repository.sendRequest.get("${AppString.baseUrl}/api/zeggo/products/$productId");
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      log("---- getProductById $result");
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetProductByIdLoadedState(GetProductByIdModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetProductByIdErrorState(result["message"]));
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

      emit(GetProductByIdErrorState(errorMessage));
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetProductByIdErrorState(e.toString()));
    }
  }
}
