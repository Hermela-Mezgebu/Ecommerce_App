import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/product_repository.dart';
import '../../data/services/api_service.dart';
import '../../domain/models/product_model.dart';



final productRepositoryProvider =
Provider<ProductRepository>((ref){

return ProductRepository(
ApiService()
);

});



final productsProvider =
FutureProvider<List<Product>>((ref) async{


final repository =
ref.watch(productRepositoryProvider);


return repository.getProducts();


});