import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/product_model.dart';
import '../../data/repositories/product_repository.dart';

final productRepositoryProvider = Provider((ref) {
  return ProductRepository();
});

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.read(productRepositoryProvider);
  return repository.getProducts();
});