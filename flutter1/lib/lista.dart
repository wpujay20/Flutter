import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/EditarProducto/Editar_Page.dart';
import 'package:flutter1/EliminarProducto/EliminarProducto.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'AgregarProducto/Producto_Page.dart';

class ListarProductos extends StatefulWidget {
  ListarProductos({Key key}) : super(key: key);

  @override
  _ListarProductosState createState() => _ListarProductosState();
}

class _ListarProductosState extends State<ListarProductos> {
  List list;

  //Instancia de la funsión Eliminiar
  final productoDelete = new ProductoDelete();
  Future getProductos() async {
    var url =
        'http://192.168.0.110/PROYECTO_MANTENIMIENTO_FLUTTER/CONTROLADOR/ProductoControlador.php?op=2';

    final response = await http.get(url, headers: {
      "Accept": "Application/json",
    });

    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Productos"),
        actions: [
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext ctx) => Producto()));
            },
            child: Text("Agregar"),
            color: Colors.blue,
            textColor: Colors.white,
          )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: getProductos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.hasError);
            }
            return snapshot.hasData
                ? Scrollbar(
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          list = snapshot.data;
                          String id = list[index]['ID'];

                          return Column(
                            children: <Widget>[
                              SizedBox(
                                width: 370.0,
                                child: ListTile(
                                  trailing: GestureDetector(
                                    child: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            productoDelete.eliminarProducto(id);
                                          });
                                        }),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                EditarProducto(
                                                  list: list,
                                                  index: index,
                                                )));
                                  },
                                  title: Text(list[index]['NOMPROD']),
                                  subtitle: Text(list[index]['PRECIO']),
                                ),
                              )
                            ],
                          );
                        }))
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
