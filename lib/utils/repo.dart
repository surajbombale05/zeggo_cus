import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zeggo_cus/constants/app_url.dart';
import 'dart:io';

import 'package:zeggo_cus/utils/storage/storage.dart';

class Repository {
  Dio dio = Dio();

  init() {
    dio.options.baseUrl = AppString.baseUrl;

    dio.interceptors.addAll([
      AuthInterceptor(),
      ErrorInterceptor(),
      PrettyDioLogger(requestBody: true, responseBody: true, error: true),
    ]);

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };

    log("Dio Initialized: ${dio.options.baseUrl}");
  }

  Dio get sendRequest => dio;
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await LocalStorageUtils.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers["Authorization"] = "Bearer $token";
    }

    return handler.next(options);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("API ERROR: ${err.message}");

    // ✅ Handle Unauthorized (Auto Logout)
    if (err.response?.statusCode == 401) {
      log("User Unauthorized - Logout");

      // Optional:
      // LocalStorageUtils.clear();
      // Navigate to login screen
    }

    // ✅ No Internet
    if (err.type == DioExceptionType.connectionError) {
      log("No Internet Connection");
    }

    // ✅ Timeout
    if (err.type == DioExceptionType.connectionTimeout) {
      log("Connection Timeout");
    }

    return handler.next(err);
  }
}
