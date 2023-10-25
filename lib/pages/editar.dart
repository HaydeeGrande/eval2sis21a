import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  final DocumentSnapshot product;

  EditProductScreen({required this.product});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController stockController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product['nombre']);
    priceController = TextEditingController(text: widget.product['precio']);
    stockController = TextEditingController(text: widget.product['stock']);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    super.dispose();
  }

  void updateProduct() {
    FirebaseFirestore.instance
        .collection('tb_productos')
        .doc(widget.product.id)
        .update({
      'nombre': nameController.text,
      'precio': priceController.text,
      'stock': stockController.text,
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actualizar Producto'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              const Text(
                'Actualizar Productos',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextFormField(
                  controller: nameController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: 'Nombre',
                      hintText: 'Digite el nombre del producto:'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextFormField(
                  controller: priceController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Precio', hintText: 'Digite el precio:'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: TextFormField(
                  controller: stockController,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Stock', hintText: 'Digite el stock:'),
                ),
              ),
              SizedBox(height: 3),
              ElevatedButton(
                  onPressed: updateProduct, child: const Text('Guardar')),
            ],
          ),
        ),
      ),
    );
  }
}
