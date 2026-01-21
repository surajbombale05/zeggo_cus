import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/features/profile_section/bloc/address/get_all_address/get_all_address_model.dart';
import 'package:zeggo_cus/main.dart';

part 'get_all_address_state.dart';

class GetAllAddressCubit extends Cubit<GetAllAddressState> {
  GetAllAddressCubit() : super(GetAllAddressInitial());

  getAllAddress() async {
    try {
      emit(GetAllAddressLoadingState());
      final resp = await repository.sendRequest.get("${AppString.baseUrl}/api/zeggo/user-addresses?user_id=$userId");
      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200) {
        if (result["status"] == true) {
          emit(GetAllAddressLoadedState(GetAllAddressModel.fromJson(result)));
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(GetAllAddressErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(GetAllAddressErrorState(e.toString()));
    }
  }
}
