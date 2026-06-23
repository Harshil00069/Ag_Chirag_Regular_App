// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:treding/Api/api_logger_interceptor.dart';
import 'api_urls.dart';


class DioClient {
  static Dio? dio;

  static Dio? getDioClient({int delay = 200000}) {
    if (dio == null) {
      dio = Dio();
      dio!.options.baseUrl = ApiUrls.domainName;
      dio!.options.connectTimeout = Duration(milliseconds: delay);
      dio!.options.receiveTimeout = Duration(milliseconds: delay);

      dio!.interceptors.add(ApiLoggerInterceptor());
    }
    return dio;
  }

  static Future<dynamic> clientPost(String apiName,
      {required Map<String, String> body, int delayTime = 200000}) async {
    print("Client Post $apiName And Body $body");
    try {
      final response = await getDioClient(delay: delayTime)!
          .post(apiName,
          data: body,
          options: Options(contentType: Headers.formUrlEncodedContentType));

      print(response.realUri);
      if (response.statusCode == 200) {
        print("in post api $apiName Body: $body And Response ${response.data}");
        return response;
      } else {
        print(response.statusMessage.toString());

      }
    } catch (error) {
      print("$error");
      rethrow;
    }
  }

  static Future clientGet(String apiName,
      {required Map<String, String> body, int delayTime = 200000}) async {
    print("Client Get $apiName And Body $body");

    try {
      final response = await getDioClient(delay: delayTime)!
          .get(apiName,
          queryParameters: body,
          options: Options(headers: {'content-type': 'text/plain'}));

      print(response.realUri);
      if (response.statusCode == 200) {
        return response;
      } else {
        print(response.statusMessage.toString());

      }
    } catch (error) {
      print("$error");
      rethrow;
    }
  }
}
