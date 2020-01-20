import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:conversor_de_moedas/home_page/api_service.dart';

class HomePageBloc extends BlocBase {
  final StreamController _streamController = StreamController();

  ApiService _apiService = ApiService();

  Sink get entrada => _streamController.sink;
  Stream get saida => _streamController.stream;

  Future<Map> consultarApi(String url) async {
    await _apiService.consultar(url).then(entrada.add);
  }

  @override
  void dispose(){
    _streamController.close();
  }
}