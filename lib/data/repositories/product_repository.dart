import '../../domain/models/product_model.dart';
import '../services/api_service.dart';


class ProductRepository{


final ApiService apiService;


ProductRepository(this.apiService);



Future<List<Product>> getProducts() async{


final data = await apiService.getProducts();


return data
.map((json)=>Product.fromJson(json))
.toList();


}

Future<List<String>> getCategories() async {
  final data = await apiService.getCategories();
  return List<String>.from(data);
}

Future<List<Product>> getProductsByCategory(String category) async {
  final data = await apiService.getProductsByCategory(category);

  return data
      .map((json) => Product.fromJson(json))
      .toList();
}


}