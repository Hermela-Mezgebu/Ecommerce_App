import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(baseUrl: ApiConstants.baseUrl),
  );

  Future<List<dynamic>> getProducts() async {
    final response = await _dio.get('/products');
    return response.data;
  }

  Future<List<dynamic>> getCategories() async {
    final response = await _dio.get('/products/categories');
    return response.data;
  }

  Future<List<dynamic>> getUsers() async {
    final response = await _dio.get('/users');
    return response.data;
  }

  Future<Map<String, dynamic>> login({
    required String username,
    required String password,
  }) async {
    final response = await _dio.post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
      },
    );

    return response.data;
  }
}