import 'package:dio/dio.dart';

import '../utils/logger.dart';
import '../utils/toast.dart';
import 'api.dart';
import 'api_error.dart';
import 'interceptor/app_log_interceptor.dart';

class HttpDio {
  static HttpDio? _httpDio;

  static HttpDio get instance {
    _httpDio ??= HttpDio();
    return _httpDio!;
  }

  late Dio _dio;

  HttpDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: Api.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      ),
    );

    _dio.interceptors.addAll([
      AppLogInterceptor(),
    ]);
  }

  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    String? baseUrl,
    bool isShowToast = true,
  }) async {
    baseUrl ??= Api.baseUrl;
    data ??= {};
    header ??= {};
    try {
      var result = await _dio.post(
        baseUrl + path,
        data: data,
        options: Options(
          responseType: ResponseType.json,
          headers: header,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );
      if (result.data == null) {
        throw ApiError('服务器异常', -1);
      } else if (result.data is String && (result.data as String).isEmpty) {
        throw ApiError('服务器异常', -1);
      } else if (result.data['code'] == ApiCode.SUCCESS) {
        return result.data;
      } else {
        Error.handleError(ApiError(result.data['message'], result.data['code']),
            isShowErrorMessage: isShowToast);
        return result.data;
      }
    } catch (e) {
      Error.handleError(e);
    }
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? header,
    String? baseUrl,
    bool isShowToast = true,
  }) async {
    Log.d('data=$data');
    baseUrl ??= Api.baseUrl;
    data ??= {};
    header ??= {};
    try {
      var result = await _dio.get(
        baseUrl + path,
        queryParameters: data,
        options: Options(responseType: ResponseType.json, headers: header),
      );
      if (result.data == null) {
        throw ApiError('服务器异常', -1);
      } else if (result.data is String && (result.data as String).isEmpty) {
        throw ApiError('服务器异常', -1);
      } else if (result.data['code'] == ApiCode.SUCCESS) {
        return result.data;
      } else {
        Error.handleError(ApiError(result.data['message'], result.data['code']),
            isShowErrorMessage: isShowToast);
        return result.data;
      }
    } catch (e) {
      Error.handleError(e);
    }
  }

  Future<dynamic> download(String urlPath, String savePath,
      ProgressCallback? onReceiveProgress) async {
    _dio.download(urlPath, savePath, onReceiveProgress: onReceiveProgress);
  }
}

class Error {
  static handleError(Object e, {bool isShowErrorMessage = true}) {
    Log.d('错误->$e');
    if (e is ApiError) {
      if (isShowErrorMessage) {
        MyToast.showToast(e.message ?? '服务器异常');
      }
      return e;
    } else if (e is DioException) {
      MyToast.showToast('连接异常，请检查网络');
      return {};
    } else {
      MyToast.showToast('未知错误');
      return {};
    }
  }
}

class ApiCode {
  static const int SUCCESS = 0;
}
