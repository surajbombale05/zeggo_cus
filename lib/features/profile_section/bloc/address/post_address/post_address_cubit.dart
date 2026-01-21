import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'package:zeggo_cus/main.dart';

part 'post_address_state.dart';

class PostAddressCubit extends Cubit<PostAddressState> {
  PostAddressCubit() : super(PostAddressInitial());

  postAdrress({
    required String addType,
    required String fullName,
    required String phoneNo,
    required String fullAddress,
    required String city,
    required String zipCode,
    required bool isPrimary,
    required String userId,
  }) async {
    try {
      emit(PostAddressLoadingState());
      final resp = await repository.sendRequest.post(
        "${AppString.baseUrl}/api/zeggo/user-addresses",
        data: {
          "add_type": addType,
          "full_name": fullName,
          "phone_no": phoneNo,
          "full_address": fullAddress,
          "city": city,
          "zip_code": zipCode,
          "is_primary": isPrimary,
          "user_id": userId,
        },
      );

      repository.sendRequest.interceptors.add(PrettyDioLogger());
      final result = resp.data;
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        if (result["status"] == true) {
          emit(PostAddressLoadedState());
        } else if (result["status"] == false) {
          log("Message:=> Status Code=> ${resp.statusCode} \n &URL=> ${resp.realUri} \n Data ${resp.data}");
          emit(PostAddressErrorState(result["message"]));
        }
      }
    } catch (e, stk) {
      log("Message:=> Catch Error  => $e $stk");
      emit(PostAddressErrorState(e.toString()));
    }
  }
}
