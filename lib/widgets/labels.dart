import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String noTienesCuenta;
  final String crearCuenta;

  const Labels(
      {Key key,
      @required this.ruta,
      @required this.noTienesCuenta,
      @required this.crearCuenta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.noTienesCuenta,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15.0,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta);
            },
            child: Text(
              this.crearCuenta,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
