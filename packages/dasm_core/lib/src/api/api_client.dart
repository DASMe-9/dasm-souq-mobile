import 'package:dio/dio.dart';

import '../auth/token_storage.dart';
import '../config/api_config.dart';

class ApiClient {
  final Dio dio;
  final TokenStorage _tokens;

  ApiClient({required ApiConfig config, required TokenStorage tokens})
      : _tokens = tokens,
        dio = Dio(BaseOptions(
          baseUrl: config.baseUrl,
          connectTimeout: config.connectTimeout,
          receiveTimeout: config.receiveTimeout,
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
        )) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _tokens.read();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          await _tokens.clear();
        }
        handler.next(e);
      },
    ));
  }
}
