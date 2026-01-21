import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/main.dart';

part 'post_wishlist_state.dart';

class PostWishlistCubit extends Cubit<PostWishlistState> {
  PostWishlistCubit() : super(PostWishlistInitial());

  postWishlist({required String productId}) async {
    try {
      emit(PostWishlistLoadingState());
      final resp = await repository.sendRequest.post(
        "${AppString.baseUrl}/api/zeggo/product-wishlist/toggle-like",
        data: {
          {"product_id": productId, "user_id": userId},
        },
      );

      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        if (result["status"] == true) {
          emit(PostWishlistLaodedState());
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(PostWishlistErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(PostWishlistErrorState(e.toString()));
    }
  }
}
