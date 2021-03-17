import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const BotonAzul({Key key, @required this.onPressed, @required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: StadiumBorder(),
        elevation: 2,
      ),
      onPressed: () {},
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
        ),
      ),
    );
  }
}
