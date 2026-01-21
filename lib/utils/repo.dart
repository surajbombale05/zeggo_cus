import 'dart:math';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';

class Repository {
  Dio dio = Dio();
  init() {
    dio.options.baseUrl = AppString.baseUrl;
    dio.interceptors.add(PrettyDioLogger());
    log(dio.options.hashCode);
  }

  Dio get sendRequest => dio;
}
