import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/user_repository.dart';
import '../../data/services/api_service.dart';
import '../../domain/models/user_model.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ApiService());
});

final userProvider = FutureProvider<UserModel>((ref) async {
  final repository = ref.watch(userRepositoryProvider);

  // Fake Store API test user
  return repository.getUser(1);
});