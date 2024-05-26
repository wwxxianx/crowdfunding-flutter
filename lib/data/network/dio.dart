import 'dart:convert';
import 'package:crowdfunding_flutter/domain/model/tokens_response.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crowdfunding_flutter/common/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class DioNetwork {
  // static const baseUrl = "https://fixed-elisabeth-ngustudio.koyeb.app/";
  static Dio provideDio() {
    Dio dio = Dio();

    // Interceptor for jwt refresh
    dio.interceptors.add(AppInterceptors(dio: dio));
    return dio;
  }
}

// Interceptor for jwt refresh
class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors({required this.dio});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var accessToken = sp.get(Constants.sharedPreferencesKey.accessToken);
    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException e, ErrorInterceptorHandler handler) async {
    if (e.response?.statusCode == 401) {
      // If a 401 response is received, refresh the access token
      SharedPreferences sp = await SharedPreferences.getInstance();
      var refreshToken =
          sp.getString(Constants.sharedPreferencesKey.refreshToken);

      // NOTE:
      // Use HTTP package as the Dio onRequest method is override to use accessToken
      // everytime, so the refreshToken will be overwritten everytime.
      final tokenRes = await http.post(
        Uri.parse('${Constants.apiUrl}auth/refresh'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
      );
      TokensResponse token = TokensResponse.fromJson(
          jsonDecode(tokenRes.body) as Map<String, dynamic>);
      // Save new tokens to sp
      sp.setString(
          Constants.sharedPreferencesKey.refreshToken, token.refreshToken);
      sp.setString(
          Constants.sharedPreferencesKey.accessToken, token.accessToken);

      // Update the request header with the new access token
      e.requestOptions.headers['Authorization'] = 'Bearer ${token.accessToken}';

      // Repeat the request with the updated header
      return handler.resolve(await dio.fetch(e.requestOptions));
    }
    return handler.next(e);
  }
}
