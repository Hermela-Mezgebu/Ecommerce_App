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


}