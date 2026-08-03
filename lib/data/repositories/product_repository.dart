import '../api/api_service.dart';
import '../models/product_model.dart';

class ProductRepository {
  final ApiService _apiService = ApiService();

  Future<List<Product>> getProducts() async {
    final data = await _apiService.getProducts();

    return data
        .map<Product>((json) => Product.fromJson(json))
        .toList();
  }
}