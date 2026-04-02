import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/main.dart';

part 'delete_address_state.dart';

class DeleteAddressCubit extends Cubit<DeleteAddressState> {
  DeleteAddressCubit() : super(DeleteAddressInitial());

  deleteAdrress({required String addressId}) async {
    try {
      emit(DeleteAddressLoadingState());
      final resp = await repository.sendRequest.delete("${AppString.baseUrl}/api/zeggo/user-addresses/$addressId");

      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(DeleteAddressLoadedState());
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(DeleteAddressErrorState(result["message"]));
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

      emit(DeleteAddressErrorState(errorMessage));
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(DeleteAddressErrorState(e.toString()));
    }
  }
}
