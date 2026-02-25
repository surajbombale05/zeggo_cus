import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'dart:io';

class Repository {
  Dio dio = Dio();

  init() {
    dio.options.baseUrl = AppString.baseUrl;

    dio.interceptors.add(PrettyDioLogger(requestBody: true, responseBody: true, error: true));

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    log("Dio Initialized: ${dio.options.baseUrl}");
  }

  Dio get sendRequest => dio;
}
