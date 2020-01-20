import 'package:conversor_de_moedas/home_page/api_service.dart';
import 'package:conversor_de_moedas/home_page/home_page_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=d8fadfa2";

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //HomePageBloc _bloc = HomePageBloc();

  final realControler = TextEditingController();
  final dolarControler = TextEditingController();
  final euroControler = TextEditingController();

  ApiService _apiService = ApiService();

  double _dolar;
  double _euro;

  void _realChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarControler.text = (real/_dolar).toStringAsFixed(2);
    euroControler.text = (real/_euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realControler.text = (dolar * this._dolar).toStringAsFixed(2);
    euroControler.text = (dolar * this._dolar / _euro).toStringAsFixed(2);
  }

  void _euroChanged(String text){
    if(text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    dolarControler.text = (euro * this._euro / this._dolar).toStringAsFixed(2);
    realControler.text = (euro * this._euro).toStringAsFixed(2);
  }

  void _clearAll(){
    realControler.text = "";
    dolarControler.text = "";
    euroControler.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("\$ Conversor de Moedas \$"),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: _apiService.consultarApi(_request),
        // ignore: missing_return
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...",
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              );
              break;
            default:
              if(snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregador dados :(",
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                _dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                _euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(Icons.monetization_on, size: 150, color: Colors.amber),
                      buildTextField("Reais", "R\$", realControler, _realChanged),
                      Divider(),
                      buildTextField("Dólares", "US\$", dolarControler, _dolarChanged),
                      Divider(),
                      buildTextField("Euros", "€", euroControler, _euroChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(String label, String prefix, TextEditingController controller, Function func){
  return TextField(
    decoration: InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.amber),
      border: OutlineInputBorder(),
      prefixText: prefix,
    ),
    style: TextStyle(
      color: Colors.amber, fontSize: 25.0,
    ),
    controller: controller,
    onChanged: func,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}
