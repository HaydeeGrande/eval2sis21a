import 'package:eval2sis21a/pages/listado.dart';
import 'package:flutter/material.dart';

import 'listado.dart';
import 'formulario.dart';
import 'inicio.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _itemDrawer = 0;
  _getDrawerItem(int position) {
    switch (position) {
      case 0:
        return Inicio();
      case 1:
        return const Listado(
          title: 'Listado de Productos',
        );
      case 2:
        return Formulario();
    }
  }

  void _onSelectItemDrawer(int pos) {
    Navigator.pop(context);
    setState(() {
      _itemDrawer = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Actividad Evaluada',
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pinkAccent,
              ),
              child: Text(
                'ITCA-FEPADE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              onTap: () {
                _onSelectItemDrawer(0);
              },
            ),
            Divider(
              color: Colors.blue,
            ),
            ListTile(
              leading: Icon(Icons.arrow_forward_ios),
              title: Text('Listado'),
              onTap: () {
                _onSelectItemDrawer(1);
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_forward_ios),
              title: Text('Formulario'),
              onTap: () {
                _onSelectItemDrawer(2);
              },
            ),
          ],
        ),
      ),
      body: _getDrawerItem(_itemDrawer),
    );
  }
}
