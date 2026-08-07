import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/api_service.dart';
import '../../data/repositories/auth_repository.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(apiServiceProvider),
  );
});