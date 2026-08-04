import 'package:dio/dio.dart';


class ApiService {

  final Dio dio;


  ApiService()
      : dio = Dio(
          BaseOptions(
            baseUrl: 'https://fakestoreapi.com',
            headers: {
              'Content-Type': 'application/json',
            },
          ),
        );


  Future<Response> post(
    String endpoint,
    Map<String, dynamic> data,
  ) async {

    return await dio.post(
      endpoint,
      data: data,
    );
  }


  Future<Response> get(
    String endpoint,
  ) async {

    return await dio.get(endpoint);
  }
}