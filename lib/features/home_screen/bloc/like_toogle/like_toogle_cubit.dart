import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/like_toogle/like_toogle.dart';
import 'package:zeggo_cus/main.dart';

part 'like_toogle_state.dart';

class LikeToogleCubit extends Cubit<LikeToogleState> {
  LikeToogleCubit() : super(LikeToogleInitial());

  like(String productId) async {
    try {
      emit(LikeToogleLoadingState());
      final resp = await repository.sendRequest.post(
        "${AppString.baseUrl}/api/zeggo/product-wishlist/toggle-like",
        data: {"product_id": productId, "user_id": userId},
      );
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      log("---- LikeToogleCubit $result");
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(LikeToogleLoadedState(LikeToggleResponse.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(LikeToogleErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(LikeToogleErrorState(e.toString()));
    }
  }
}
