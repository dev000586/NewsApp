import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class RequestInterceptor extends Interceptor {
  final Dio api = Dio();

  //* ============================ On-Request =====================
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('REQUEST[${options.method}] => ${options.uri}');
    return super.onRequest(options, handler);
  }

  //* ============================ On-Error =====================
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
        "=== Dio Error Occured ==> ErrorResponse[${err.response?.statusCode}] ===");
    if (err.type == DioErrorType.response) {
      print('ErrorResponse[${err.response?.statusCode}] =>${err.response}');
    }
    if (err.type == DioErrorType.connectTimeout) {
      print('check your connection');
    }

    if (err.type == DioErrorType.receiveTimeout) {
      print('unable to connect to the server');
    }

    if (err.type == DioErrorType.other) {
      print('Something went wrong');
    }
    // consider to remap this error to generic error.
    return super.onError(err, handler);
  }


  //* ============================ On-Response =====================
  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    print("=== Dio Success Occured ==> RESPONSE[${response.statusCode}] ===");
    return super.onResponse(response, handler);
  }

}

//! ========================= Dio Client Setup ===========================
class DioClient {
  final Dio _dio = Dio();
  final String _baseUrl = ApiConst.BASEURL;
  final RequestInterceptor requestInterceptor = RequestInterceptor();

  DioClient();

  BaseOptions _dioOptions() {
    BaseOptions opts = BaseOptions();
    opts.baseUrl = _baseUrl;
    opts.connectTimeout = 60000;
    opts.receiveTimeout = 60000;
    opts.sendTimeout = 60000;
    return opts;
  }

  Dio provideDio() {
    _dio.options = _dioOptions();
    _dio.interceptors.add(requestInterceptor);
    return _dio;
  }
}
