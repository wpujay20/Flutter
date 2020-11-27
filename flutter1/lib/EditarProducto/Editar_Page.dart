import 'package:flutter/material.dart';
import 'package:flutter1/AgregarProducto/AgregarProducto.dart';
import 'package:flutter1/lista.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class EditarProducto extends StatefulWidget {
  final List list;
  final int index;
  EditarProducto({this.list, this.index});
  @override
  _ProductoState createState() => _ProductoState();
}

class _ProductoState extends State<EditarProducto> {
  final productosProvider = new ProductosProvider();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String nameProd;
  String costo;

  TextEditingController nomProd;
  TextEditingController precio;
  TextEditingController id;

  Future _editar() async {
    var url =
        'http://192.168.0.110/PROYECTO_MANTENIMIENTO_FLUTTER/CONTROLADOR/ProductoControlador.php?op=4';
    final response = await http.post(url, body: {
      "ID": widget.list[widget.index]['ID'],
      "NOMPROD": nomProd.text,
      "PRECIO": precio.text,
    });
    return json.decode(response.body);
  }

  @override
  void initState() {
    nomProd =
        new TextEditingController(text: widget.list[widget.index]['NOMPROD']);
    precio =
        new TextEditingController(text: widget.list[widget.index]['PRECIO']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar producto"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            // ignore: deprecated_member_use
            autovalidate: _autoValidate,
            child: Column(
              children: [_nomProducto(), _precio(), _btnEditar()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nomProducto() {
    return TextFormField(
      controller: nomProd,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Ingrese nombre del producto'),
      validator: (String valor) {
        if (valor.length < 1) {
          return 'Por favor ingrese el nombre del producto';
        } else {
          return null;
        }
      },
      onSaved: (String val) {
        nameProd = val;
      },
    );
  }

  Widget _precio() {
    return TextFormField(
      controller: precio,
      decoration: InputDecoration(
          border: OutlineInputBorder(), hintText: 'Ingrese el precio'),
      validator: (String valor) {
        if (valor.length < 1) {
          return 'Por favor ingrese el precio del producto';
        } else {
          return null;
        }
      },
      onSaved: (String val) {
        costo = val;
      },
    );
  }

  Widget _btnEditar() {
    return RaisedButton(
      onPressed: () {
        _validar();
      },
      child: Text("Editar"),
    );
  }

  void _validar() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      //cuando sea correcto
      _editar();

      // Todo navegando de una niterface a otro
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => ListarProductos()));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
