// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dokkan/core/config/constants.dart';
import 'package:dokkan/core/network/interceptors/auth_interceptor.dart';
import 'package:dokkan/core/network/interceptors/language_interceptor.dart';
import 'package:dokkan/core/services/storage_services/storage_service.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String APPLICATION_JSON = 'application/json';
const String CONTENT_TYPE = 'content-type';
const String ACCEPT = 'accept';
const String AUTHORIZATION = 'authorization';
const String DEFAULT_LANGUAGE = 'Accept-Language';
const String SECRET_KEY = 'Accept-Secret-Key';

enum RequestMethod { GET, POST, PUT, DELETE, PATCH }

class DioFactory {
  late final Dio _dio;
  final StorageService _storageService;

  Dio get dio => _dio;

  DioFactory(this._storageService) {
    final Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      'language': 'en',
    };

    _dio = Dio(
      BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        followRedirects: false,
        receiveDataWhenStatusError: true,
      ),
    );

    _dio.interceptors.add(AuthInterceptor(_storageService));
    _dio.interceptors.add(LanguageInterceptor());

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
    }
  }

  Future<Response> request(
    String path, {
    RequestMethod method = RequestMethod.GET,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Map<String, dynamic>? headers,
  }) async {
    return await _dio.request(
      path,
      data: body,
      queryParameters: queryParameters,
      options: Options(method: method.name, headers: headers),
    );
  }
}

