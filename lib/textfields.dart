import 'package:flutter/material.dart';

Widget all_textfields(
    {String name_of_field,
    Widget icon,
    TextEditingController controller,
    Color color_of_hint,
    bool obsecuretext = false}) {
  return Container(
    child: TextField(
      obscureText: obsecuretext,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: icon,
          hintText: '$name_of_field',
          hintStyle: TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: color_of_hint)),
    ),
  );
}


