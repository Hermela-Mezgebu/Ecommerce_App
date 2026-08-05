import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/product_repository.dart';
import '../../data/services/api_service.dart';
import '../../domain/models/product_model.dart';

final categoryRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository(ApiService());
});

final categoriesProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.getCategories();
});

final productsByCategoryProvider =
    FutureProvider.family<List<Product>, String>((ref, category) async {
  final repository = ref.watch(categoryRepositoryProvider);
  return repository.getProductsByCategory(category);
});