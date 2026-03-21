import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_cafe/get_all_cafe_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_all_cafe_state.dart';

class GetAllCafeCubit extends Cubit<GetAllCafeState> {
  GetAllCafeCubit() : super(GetAllCafeInitial());

  getAllCafeProduct() async {
    try {
      emit(GetAllCafeLoadingState());
      final resp = await repository.sendRequest.get(
        "${AppString.baseUrl}/api/zeggo/products?is_cafe=true",
        queryParameters: {if (userId != null && userId!.isNotEmpty) "user_id": userId},
      );
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      log("---- getAllCafeProduct $result");
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetAllCafeLoadedState(GetAllCafeModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetAllCafeErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetAllCafeErrorState(e.toString()));
    }
  }
}
