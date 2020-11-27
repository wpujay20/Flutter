import 'dart:convert';

import 'package:http/http.dart' as http;

class ProductoDelete {
  final String _url =
      'http://192.168.0.110/PROYECTO_MANTENIMIENTO_FLUTTER/CONTROLADOR/ProductoControlador.php';

  Future<bool> eliminarProducto(String id) async {
    try {
      final url = '$_url/?op=3&ID=$id';

      final resp = await http.post(url);

      final decodeData = json.decode(resp.body);
      print(decodeData);
      print(url);
      if (resp.statusCode == 200) {
        print(resp.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return true;
  }
}
