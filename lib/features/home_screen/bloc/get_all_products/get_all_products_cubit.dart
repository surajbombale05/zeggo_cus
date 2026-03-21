import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_all_products_state.dart';

class GetAllProductsCubit extends Cubit<GetAllProductsState> {
  GetAllProductsCubit() : super(GetAllProductsInitial());

  getAllProduct() async {
    try {
      emit(GetAllProductsLoadingState());
      final resp = await repository.sendRequest.get(
        "${AppString.baseUrl}/api/zeggo/products",
        queryParameters: {if (userId != null && userId!.isNotEmpty) "user_id": userId},
      );
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      log("---- getAllProduct $result");
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetAllProductsLoadedState(GetAllProductModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetAllProductsErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetAllProductsErrorState(e.toString()));
    }
  }
}
