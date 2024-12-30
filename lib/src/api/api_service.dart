import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../src.dart';

abstract class HttpRepo {
  Future<ApiResponse> get(String path, {bool requiresToken});
  Future<ApiResponse> post(String path, dynamic body, {bool requiresToken});
  Future<ApiResponse> patch(String path, dynamic body);
  Future<ApiResponse> delete(String path);
}

class HttpServices implements HttpRepo {
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(
        seconds: 30,
      ),
      baseUrl: GlobalConfig.baseUrl,
      responseType: ResponseType.json,
      contentType: ContentType.json.toString(),
      validateStatus: (status) => status! < 505,
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          bool requiresToken = options.extra['requiresToken'] ?? true;
          if (requiresToken) {
            SharedPreferencesService sharedPref = SharedPreferencesService();
            var token = await sharedPref.getStringPref('userData');
            var sessionProvider = SessionProvider();
            options.headers['Authorization'] =
                'Bearer ${token != null ? token['accessToken'] : ''}';
            print('token is ${token != null ? token['accessToken'] : ''}');

            if (await sessionProvider.isSessionExpired()) {
              Utility.handleSessionExpired();
            }
            print('is expired ${sessionProvider.isSessionExpired()}');
            print('get Remaining time ${sessionProvider.remainingTime()}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (response.statusCode == 401) {
            // Session expired
            Utility.handleSessionExpired();
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (e.response?.statusCode == 401) {
            // Session expired
            Utility.handleSessionExpired();
          }
          return handler.next(e);
        },
      ),
    );

  @override
  Future<ApiResponse> get(String path, {bool requiresToken = true}) async {
    try {
      print('global base url ${GlobalConfig.baseUrl}/$path');
      Response response = await dio.get(
        path,
        options: Options(extra: {'requiresToken': requiresToken}),
      );
      var decodedResponse = json.decode(
        response.toString(),
      );

      if (decodedResponse['status'] != "success") {
        throw (decodedResponse['message']);
      }
      return apiResponseFromJson(
        json.encode(
          decodedResponse,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> post(String path, dynamic body,
      {bool requiresToken = true}) async {
    try {
      print('global base url ${GlobalConfig.baseUrl}$path');

      Response response = await dio.post(
        path,
        data: body,
        options: Options(extra: {'requiresToken': requiresToken}),
      );
      var decodedResponse = json.decode(
        response.toString(),
      );
      if (decodedResponse['status'] != "success") {
          throw (decodedResponse['message']);
      }
      return apiResponseFromJson(
        json.encode(
          decodedResponse,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> patch(String path, dynamic body) async {
    try {
      print('global base url ${GlobalConfig.baseUrl}/$path');

      //make body common in future
      Response response = await dio.patch(path, data: body);
      var decodedResponse = json.decode(
        response.toString(),
      );
      return apiResponseFromJson(
        json.encode(
          decodedResponse,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApiResponse> delete(String path) async {
    try {
      //make body common in future
      Response response = await dio.post(path);
      var decodedResponse = json.decode(
        response.toString(),
      );
      return apiResponseFromJson(
        json.encode(
          decodedResponse,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}
