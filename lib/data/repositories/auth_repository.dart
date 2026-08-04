import '../services/api_service.dart';


class AuthRepository {

  final ApiService apiService;


  AuthRepository(this.apiService);



  Future<String> login(
    String username,
    String password,
  ) async {


    final response = await apiService.post(
      '/auth/login',
      {
        "username": username,
        "password": password,
      },
    );


    return response.data['token'];

  }

}