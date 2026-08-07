import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://fakestoreapi.com',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  ));

  // Add interceptor for authentication
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      // You can add token here if needed
      return handler.next(options);
    },
    onError: (error, handler) {
      // Handle errors globally
      return handler.next(error);
    },
  ));

  return dio;
});