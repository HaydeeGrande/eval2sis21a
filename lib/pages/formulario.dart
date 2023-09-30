
import 'package:flutter/material.dart';

class Formulario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(

        children: [
          SizedBox(height:60),
          Text('Regístro de Productos',
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.purple

            ),

          ),
          SizedBox(height:50),
          Padding(
            padding: const EdgeInsets.only(left:50, right:50),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(

                  labelText: 'Nombre',
                  hintText: 'Digite el nombre del producto:'
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:50, right:50),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(

                  labelText: 'Precio',
                  hintText: 'Digite el precio:'
              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:50, right:50),
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(

                  labelText: 'Stock',
                  hintText: 'Digite el stock:'
              ),

            ),
          ),
          SizedBox(height:50),


          ElevatedButton(

              onPressed: (

                  ){
              },

              child: Text('Guardar')

          ),
          SizedBox(height:10),
          Text(
            'Se guardara los productos en nuestra base de datos',
            textAlign: TextAlign.center,

            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.red,),

          ),
          Text(
            ',puedes consultarlo en nuestro listado de productos',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.normal,color: Colors.red),

          ),



        ],

      ),
    );
  }
}