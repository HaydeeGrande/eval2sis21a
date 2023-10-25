import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eval2sis21a/pages/editar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Editar Productos',
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Productos'),
      ),
      body: ProductList(),
    );
  }
}

class ProductList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('tb_productos').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        List<DocumentSnapshot> products = snapshot.data!.docs;
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            DocumentSnapshot product = products[index];
            return Card(
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      product['nombre'],
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    subtitle: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Icon(Icons.attach_money, color: Colors.green),
                          Text(
                            'Precio: ${product['precio']} | ',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Icon(Icons.store, color: Colors.orange),
                          Text(
                            'Stock: ${product['stock']}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            color: Theme.of(context).primaryColorDark,
                            tooltip: 'Editar',
                            onPressed: () {
                              // Navega a la pantalla de edición y pasa el producto
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    EditProductScreen(product: product),
                              ));
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            tooltip: 'Eliminar',
                            onPressed: () {
                              _confirmEliminar(context, product);
                              // Elimina el producto
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _confirmEliminar(BuildContext context, product) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text('¿Está seguro que desea eliminar este producto?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('tb_productos')
                    .doc(product.id)
                    .delete();
                Navigator.of(context).pop();
                // _eliminarProducto(BuildContext context, product);
              },
              child:
                  const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _eliminarProducto(BuildContext context, product) {
    FirebaseFirestore.instance
        .collection('tb_productos')
        .doc('tb_productos/${product['id']}')
        .delete();
  }
}

// class Listado extends StatefulWidget {
//   const Listado({super.key, required this.title});

//   final String title;

//   @override
//   State<Listado> createState() => listadoState();
// }

// class listadoState extends State<Listado> {
//   void getProductos() async {
//     CollectionReference collectionReference =
//         FirebaseFirestore.instance.collection("tb_productos");
//     QuerySnapshot mensajes = await collectionReference.get();
//     if (mensajes.docs.length != 0) {
//       for (var doc in mensajes.docs) {
//         print(doc.data());
//         //chatsx.add(doc.data());
//       }
//     }
//   }

//   Future<List> getMensajes() async {
//     List chats = [];
//     CollectionReference collectionReference =
//         FirebaseFirestore.instance.collection("tb_productos");
//     QuerySnapshot mensajes = await collectionReference.get();
//     if (mensajes.docs.length != 0) {
//       for (var doc in mensajes.docs) {
//         print(doc.data());
//         chats.add(doc.data());
//       }
//     }
//     return chats;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//       // ),
//       body: FutureBuilder(
//         future: getMensajes(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data?.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   elevation: 5,
//                   margin: EdgeInsets.all(10),
//                   child: Column(
//                     children: [
//                       ListTile(
//                         title: Text(
//                           "${snapshot.data?[index]["nombre"]}",
//                           style: const TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.blue,
//                           ),
//                         ),
//                         subtitle: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Row(
//                             children: [
//                               Icon(Icons.attach_money, color: Colors.green),
//                               Text(
//                                 "Precio: ${snapshot.data?[index]["precio"].toString()} | ",
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               Icon(Icons.store, color: Colors.orange),
//                               Text(
//                                 "Stock: ${snapshot.data?[index]["stock"].toString()}",
//                                 style: const TextStyle(
//                                   fontSize: 14,
//                                   color: Colors.grey,
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.edit),
//                                 color: Theme.of(context).primaryColorDark,
//                                 tooltip: 'Editar',
//                                 onPressed: () {
//                                   // Navega a la pantalla de edición y pasa el producto
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) =>
//                                         EditProduct(product: product),
//                                   ));
//                                 },
//                               ),
//                               IconButton(
//                                 icon: const Icon(Icons.delete),
//                                 color: Theme.of(context).errorColor,
//                                 tooltip: 'Eliminar',
//                                 onPressed: () {
//                                   // _confirmEliminar(context, product);
//                                   // Elimina el producto
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Center(
//               child: Text('No hay datos disponibles.'),
//             );
//           }
//         },
//       ),
//     );

//     // This trailing comma makes auto-formatting nicer for build methods.
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getProductos();
//     //getData();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }
// }
