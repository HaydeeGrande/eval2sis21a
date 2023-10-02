import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Listado extends StatefulWidget {
  const Listado({super.key, required this.title});

  final String title;

  @override

  State<Listado> createState() => listadoState();
}

class listadoState extends State<Listado> {

  void getProductos() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("tb_productos");
    QuerySnapshot mensajes = await collectionReference.get();
    if(mensajes.docs.length != 0){
      for (var doc in mensajes.docs){
        print(doc.data());
        //chatsx.add(doc.data());
      }
    }
  }



  Future<List> getMensajes() async {
    List chats = [];
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("tb_productos");
    QuerySnapshot mensajes = await collectionReference.get();
    if(mensajes.docs.length != 0){
      for (var doc in mensajes.docs){
        print(doc.data());
        chats.add(doc.data());
      }
    }
    return chats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getMensajes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      "${snapshot.data?[index]["nombre"]}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Icon(Icons.attach_money, color: Colors.green),
                        Text(
                          "Precio: ${snapshot.data?[index]["precio"].toString()} | ",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Icon(Icons.store, color: Colors.orange),
                        Text(
                          "Stock: ${snapshot.data?[index]["stock"].toString()}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('No hay datos disponibles.'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getProductos,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),

    );


    // This trailing comma makes auto-formatting nicer for build methods.

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductos();
    //getData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

}