import 'package:dio/dio.dart';

class ApiService {
  final dio = Dio();

  consultar(String url) async {
    Response response = await dio.get(url);
    print(response.data);
    return response.data;
  }

  Future<Map> consultarApi(String url) async {
    Response response = await dio.get(url);
    return response.data;
  }
}