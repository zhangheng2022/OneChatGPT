import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioSingleton {
  static final Dio _dio = Dio();

  static Dio get instance => _dio;

  DioSingleton._();

  static void init() {
    _dio.interceptors.add(DioInterceptor());
  }
}

class DioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('Request: ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('Response: ${response.statusCode}');
    super.onResponse(response, handler);
  }
}
