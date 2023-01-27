import 'package:flutter/material.dart';

class Headline extends StatelessWidget {
  final String title;
  const Headline({Key? key,this.title=''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            color: Colors.white,
            fontSize: 35.0,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center);
  }
}
