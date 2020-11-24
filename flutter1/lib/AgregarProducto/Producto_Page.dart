import 'package:flutter/material.dart';

import 'package:flutter1/AgregarProducto/AgregarProducto.dart';
import 'package:flutter1/lista.dart';

class Producto extends StatefulWidget {
  @override
  _ProductoState createState() => _ProductoState();
}

final productosProvider = new ProductosProvider();

class _ProductoState extends State<Producto> {
  final productosProvider = new ProductosProvider();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  String nameProd;
  String costo;

  TextEditingController nomProd = new TextEditingController();
  TextEditingController precio = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agregar Productos"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              children: [_nomProducto(), _precio(), _btnGuardar()],
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
        hintText: 'Ingrese nombre del producto',
      ),
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
        //por ver creo q es int
        if (valor.length < 1) {
          return 'Por favor ingrese el precio del producto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _btnGuardar() {
    return RaisedButton(
      onPressed: () {
        _validar();
      },
      child: Text('Guardar'),
    );
  }

  void _validar() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      //cuando sea correcto
      productosProvider.agregarProducto(nomProd.text, precio.text);
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
