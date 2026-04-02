import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/profile_section/bloc/get_all_wishlist/get_all_wishlist_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_all_wishlist_state.dart';

class GetAllWishlistCubit extends Cubit<GetAllWishlistState> {
  GetAllWishlistCubit() : super(GetAllWishlistInitial());

  getAllWishlist() async {
    try {
      emit(GetAllWishlistLoadingState());
      final resp = await repository.sendRequest.get("${AppString.baseUrl}/api/zeggo/product-wishlist/user/$userId");
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetAllWishlistLoadedState(GetAllWishlistModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetAllWishlistErrorState(result["message"]));
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

      emit(GetAllWishlistErrorState(errorMessage));
    }  catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetAllWishlistErrorState(e.toString()));
    }
  }
}
