import 'package:conversor_de_moedas/home_page/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
  return MaterialApp(
    title: "Conversor de Moedas",
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)))
    ),
    home: Home(),
  );
}
}