import 'package:dio/dio.dart';

class DioHelper {
  static Dio createDio() {
    final dio = Dio(BaseOptions(
      baseUrl: 'https://your-api.com/api', // ✨ غيّر الرابط حسب APIك
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ));

    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));

    return dio;
  }
}
