import 'package:flutter/material.dart';

class Inicio extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text ('Maria Haydee Villalta',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.purple

              )
          ),
          CircleAvatar(
              backgroundImage: AssetImage('images/imagen2.jpeg'
              ),
              radius: 130
          ),
          Text ('maria.villalta22@itca.edu.sv',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                  color: Colors.pink

              )
          ),
          SizedBox(height:20),

          Text ('Jenifer Milena Duran',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.purple

              )
          ),
          CircleAvatar(
              backgroundImage: AssetImage('images/imagen1.jpeg'
              ),
              radius: 130
          ),
          Text ('jenifer.duran22@itca.edu.sv',
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 25,
                  color: Colors.pink

              )
          ),
          SizedBox(height:50),
          // Image.asset('images/imagen1.jpg'),
        ],

      ),
    );



  }




}