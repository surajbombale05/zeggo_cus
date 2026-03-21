import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_all_product_by_catid_and_subcatid_state.dart';

class GetAllProductByCatidAndSubcatidCubit extends Cubit<GetAllProductByCatidAndSubcatidState> {
  GetAllProductByCatidAndSubcatidCubit() : super(GetAllProductByCatidAndSubcatidInitial());

  getAllProductByCatIdAndSubId(String catId, String subCatId) async {
    try {
      emit(GetAllProductByCatidAndSubcatidLoadingState());
      final resp = await repository.sendRequest.get(
        "${AppString.baseUrl}/api/zeggo/products?category_id=$catId&subcategory_id=$subCatId",
          queryParameters: {
        if (userId != null && userId!.isNotEmpty)
          "user_id": userId,
      },
      );
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      log("---- getAllProductByCatIdAndSubId $result");
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetAllProductByCatidAndSubcatidLoadedState(GetAllProductModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetAllProductByCatidAndSubcatidErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetAllProductByCatidAndSubcatidErrorState(e.toString()));
    }
  }
}
