import 'package:dio/dio.dart';

class ApiService {
  final Dio dio;

  ApiService()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://fakestoreapi.com',
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );

  // Generic GET
  Future<Response> get(String endpoint) async {
    return await dio.get(endpoint);
  }

  // Generic POST
  Future<Response> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {
    return await dio.post(
      endpoint,
      data: data,
    );
  }

  // Products API
  Future<List<dynamic>> getProducts() async {
    final response = await get('/products');
    return response.data;
  }
  Future<List<dynamic>> getCategories() async {
  final response = await get('/products/categories');
  return response.data;
}

Future<List<dynamic>> getProductsByCategory(String category) async {
  final response = await get('/products/category/$category');
  return response.data;
}
}