import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/trendings/bloc/get_all_trending_product_/get_all_trending_product_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_all_trending_product_state.dart';

class GetAllTrendingProductCubit extends Cubit<GetAllTrendingProductState> {
  GetAllTrendingProductCubit() : super(GetAllTrendingProductInitial());

  getAllTrendingProduct() async {
    try {
      emit(GetAllTrendingProductLodingState());
      final resp = await repository.sendRequest.get("${AppString.baseUrl}/api/zeggo/products?is_trending=true");
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetAllTrendingProductLoadedState(GetAllTrendingProductModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetAllTrendingProductErrorState(result["message"]));
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

      emit(GetAllTrendingProductErrorState(errorMessage));
    }catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetAllTrendingProductErrorState(e.toString()));
    }
  }
}
