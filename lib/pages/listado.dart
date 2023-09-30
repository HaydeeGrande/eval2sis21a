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
        builder: ((context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder:((context,index){
                  return Text(snapshot.data?[index]["nombre"] + "-" +
                      snapshot.data?[index]["precio"]+ "-" +snapshot.data?[index]["stock"]);
                })
            );

          }else{
            return const Center(
                child: CircularProgressIndicator()
            );
          }
        }),
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