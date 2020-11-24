import 'package:flutter/material.dart';
import 'package:flutter1/lista.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'lista',
      routes: {'lista': (_) => ListarProductos()},
    );
  }
}
