import 'package:eval2sis21a/login_page.dart';
import 'package:eval2sis21a/pages/formulario.dart';
import 'package:eval2sis21a/pages/inicio.dart';
import 'package:eval2sis21a/pages/listado.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _item = 0;

  showAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cerrar sesion'),
            content: const Text('Seguro que deseas Cerrar Sesión?'),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 102, 41)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancelar')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 2, 214, 97)),
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: const Text(
                    'Cerrar Sesion',
                  )),
            ],
          );
        });
  }

  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return ProductListScreen();
      case 1:
        return Formulario();
      case 2:
        return Inicio();
      // case 3: return SignUpPage();
    }
  }

  void setItemDrawer(int position) {
    Navigator.pop(context); // close the drawer
    setState(() {
      _item = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 203, 162, 245),
        title: Text('Actividad de login'),
        actions: [
          IconButton(
              onPressed: () {
                showAlertDialog();
                // FirebaseAuth.instance.signOut();
                //     Navigator.pushReplacement(context,
                //         MaterialPageRoute(builder: (context) => LoginPage()));
              },
              icon: const Icon(Icons.login_sharp))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 203, 162, 245),
              ),
              child: Text(
                'Menu Productos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              selected: (0 == _item),
              leading: Icon(Icons.home),
              title: Text('Productos'),
              onTap: () {
                setItemDrawer(0);
              },
            ),
            ListTile(
              selected: (1 == _item),
              leading: Icon(Icons.arrow_forward_ios),
              title: Text('Registro Producto'),
              onTap: () {
                setItemDrawer(1);
              },
            ),
            ListTile(
              selected: (1 == _item),
              leading: Icon(Icons.arrow_forward_ios),
              title: Text('Acerca de mi'),
              onTap: () {
                setItemDrawer(2);
              },
            ),

            //   ListTile(
            //     selected: (3==_item),
            //  leading: Icon(Icons.arrow_forward_ios),
            //       title: Text('SignUpPage'),
            //     onTap: (){
            //       setItemDrawer(3);
            //     },
            //   ),
          ],
        ),
      ),
      body: getDrawerItemWidget(_item),
    );
  }
}
