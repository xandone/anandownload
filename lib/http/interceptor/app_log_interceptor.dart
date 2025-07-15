import 'package:dio/dio.dart';

import '../../utils/logger.dart';

class AppLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra["ts"] = DateTime.now().millisecondsSinceEpoch;
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Log.e("error:${err.message}", err.stackTrace);
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Log.i('response.data=${response.data}');
    super.onResponse(response, handler);
  }
}
