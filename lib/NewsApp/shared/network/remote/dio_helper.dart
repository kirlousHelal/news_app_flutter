import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(BaseOptions(
        baseUrl: "https://newsapi.org/", receiveDataWhenStatusError: true));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> map,
  }) async {
    return dio!.get(
      url,
      queryParameters: map,
    );
  }
}
