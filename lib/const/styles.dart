import 'package:flutter/material.dart';

Color gradient1 = Color(0xffC1E8CB);
Color gradient2 = Color(0xff00A862);
Color background = const Color(0xff00864e);

class Styles {
  Styles._();

  static Color gradient1Color = gradient1;
  static Color gradient2Color = gradient2;
  static Color backgroundColor = background;
  static Color buttonColor = Color(0xff00A862);
  static Color appBarColor = Color(Colors.green.value);
  static Color highlightColor = Color(Colors.green.value);
  static Color yellowColor = Color(Colors.amber.value);

  static imagePath(name) => 'assets/images/$name';
}
