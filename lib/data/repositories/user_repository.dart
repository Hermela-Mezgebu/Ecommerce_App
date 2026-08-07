import '../../domain/models/user_model.dart';
import '../services/api_service.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository(this.apiService);

  Future<UserModel> getUser(int id) async {
    final data = await apiService.getUser(id);
    return UserModel.fromJson(data);
  }
}