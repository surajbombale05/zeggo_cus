import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_category/get_all_category_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_all_category_state.dart';

class GetAllCategoryCubit extends Cubit<GetAllCategoryState> {
  GetAllCategoryCubit() : super(GetAllCategoryInitial());

  getAllCategory() async {
    try {
      emit(GetAllCategoryLoadingState());
      final resp = await repository.sendRequest.get("${AppString.baseUrl}/api/zeggo/categories");
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      log("---- getAllCategory $result");
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetAllCategoryLoadedState(GetCategoryModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetAllCategoryErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetAllCategoryErrorState(e.toString()));
    }
  }
}
