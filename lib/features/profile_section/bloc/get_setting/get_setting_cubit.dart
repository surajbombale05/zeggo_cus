import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/profile_section/bloc/get_setting/get_setting_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_setting_state.dart';

class GetSettingCubit extends Cubit<GetSettingState> {
  GetSettingCubit() : super(GetSettingInitial());

  getSetting() async {
    try {
      emit(GetSettingLoadingState());
      final resp = await repository.sendRequest.get("${AppString.baseUrl}/api/zeggo/admin-setting");
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      log("---- getAllCategory $result");
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetSettingLoadedState(GetSettingModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetSettingErrorState(result["message"]));
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

      emit(GetSettingErrorState(errorMessage));
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetSettingErrorState(e.toString()));
    }
  }
}
