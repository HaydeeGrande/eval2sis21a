import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eval2sis21a/pages/listado.dart';
import 'package:flutter/material.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

class Formulario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _nombreControllers =
        TextEditingController(text: "");
    final TextEditingController _precioControllers =
        TextEditingController(text: "");
    final TextEditingController _stockControllers =
        TextEditingController(text: "");

    Future<void> addProductos(
        String nombre, String precio, String stock) async {
      await db
          .collection('tb_productos')
          .add({"nombre": nombre, "precio": precio, "stock": stock});
    }


    return Center(
      child: Column(

        children: [
          SizedBox(height: 50),
          Text(
            'Regístro de Productos',
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.purple),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: TextField(
              controller: _nombreControllers,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  labelText: 'Nombre',
                  hintText: 'Digite el nombre del producto:'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: TextField(
              controller: _precioControllers,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Precio', hintText: 'Digite el precio:'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: TextField(
              controller: _stockControllers,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Stock', hintText: 'Digite el stock:'),
            ),
          ),
          SizedBox(height:3),
          ElevatedButton(
              onPressed: () async {
                //print('Sus nombres son: ' + _nombresControllers.text);
                // //print('Sus apellidos son: ' + _apellidosControllers.text);
                // //await addAlumno(_nombresControllers.text, _apellidosControllers.text);
                await addProductos(_nombreControllers.text,
                        _precioControllers.text, _stockControllers.text)
                    .then((_) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Listado(title: 'Lista de Productos')));
                });
              },
              child: const Text('Guardar')),

          // SizedBox(height:50),
          // ElevatedButton(
          //     onPressed: (
          //         ){
          //     },
          //     child: Text('Guardar')
          // ),
          SizedBox(height: 10),
          Text(
            'Se guardara los productos en nuestra base de datos',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.red,
            ),
          ),
          Text(
            ',puedes consultarlo en nuestro listado de productos',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.normal, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
