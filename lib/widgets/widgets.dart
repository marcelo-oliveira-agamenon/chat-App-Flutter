import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(
    title: Text("adsda"),
  );
}

InputDecoration textFieldInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.white54,
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.white,
      ),
    ),
  );
}

TextStyle simpleTextFieldStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 18,
  );
}

TextStyle mediumTextFieldStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
  );
}
