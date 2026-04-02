import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_trending/get_all_trending_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_all_trending_state.dart';

class GetAllTrendingCubit extends Cubit<GetAllTrendingState> {
  GetAllTrendingCubit() : super(GetAllTrendingInitial());

  getAllTrendingProduct() async {
    try {
      emit(GetAllTrendingLoadingState());
      final resp = await repository.sendRequest.get(
        "${AppString.baseUrl}/api/zeggo/products?is_trending=true",
        queryParameters: {if (userId != null && userId!.isNotEmpty) "user_id": userId},
      );
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      log("---- getAllTrendingProduct $result");
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetAllTrendingLoadedState(GetAllTrendingModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetAllTrendingErrorState(result["message"]));
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

      emit(GetAllTrendingErrorState(errorMessage));
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetAllTrendingErrorState(e.toString()));
    }
  }
}
