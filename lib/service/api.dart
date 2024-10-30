import 'dart:async';
import 'dart:convert';
import "package:dio/dio.dart";
import 'package:flutter/foundation.dart';
import '../widgets/loadding_widget.dart';
import 'package:truyen_full/model/category.dart';

class ClientApi {
  Dio init() {
    Dio _dio = Dio();
    _dio.interceptors.add(CustomInterceptors(_dio));

    ///url api
    _dio.options.baseUrl = "https://truyen-clone.getdata.one";
    _dio.options.receiveTimeout = 100000;
    return _dio;
  }
}

class CustomInterceptors extends QueuedInterceptor {
  final Dio _dio;
  CustomInterceptors(this._dio);

  void showLoading() {
    if (_dio.options.headers['isLoading'] ?? true) {
      Loading.show();
    }
  }

  void hideLoading() {
    if (_dio.options.headers['isLoading'] ?? true) {
      Loading.hide();
    }
  }

  // static parseIsolate(String dataBody) {
  //   final parsed = jsonDecode(dataBody).cast<Map<String, dynamic>>();

  //   return parsed.map<Category>((json) => Category.fromJson(json)).toList();
  // }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    showLoading();
    debugPrint(
      'REQUEST[${options.method}] => PATH: ${options.path}',
    );

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) {
    hideLoading();
    // if (kDebugMode) {
    //   print("In File: api_client.dart, Line: 21 $response ");
    //   print(
    //     'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    //   );
    // }
    super.onResponse(response, handler);
    return Future.value(response);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    hideLoading();
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );

    debugPrint('$err');
    Map<String, dynamic>? data = err.response?.data;

    if (kDebugMode) {
      print("In File: api_client.dart, Line: 39 ${err.response} ");
    }

    super.onError(err, handler);
    return Future.error(err);
  }
}
