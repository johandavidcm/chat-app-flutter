import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const CustomInput(
      {Key key,
      @required this.icon,
      @required this.placeholder,
      @required this.textController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20.0),
        margin: EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: Offset(0, 5),
                  blurRadius: 5)
            ]),
        child: TextField(
          autocorrect: false,
          controller: this.textController,
          keyboardType: this.keyboardType,
          obscureText: this.isPassword,
          decoration: InputDecoration(
              prefixIcon: Icon(this.icon),
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              hintText: this.placeholder),
        ));
  }
}
