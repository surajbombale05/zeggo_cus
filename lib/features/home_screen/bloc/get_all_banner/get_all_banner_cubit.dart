import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/home_screen/bloc/get_all_banner/get_all_banner_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_all_banner_state.dart';

class GetAllBannerCubit extends Cubit<GetAllBannerState> {
  GetAllBannerCubit() : super(GetAllBannerInitial());

  getAllBanner() async {
    try {
      emit(GetAllBannerLoadingState());
      final resp = await repository.sendRequest.get("${AppString.baseUrl}/api/zeggo/banners");
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      log("---- getAllBanner $result");
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetAllBannerLoadedState(GetAllBannerModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetAllBannerErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetAllBannerErrorState(e.toString()));
    }
  }
}
