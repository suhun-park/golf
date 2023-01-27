import 'package:flutter/material.dart';


class CustomImageBox extends StatelessWidget {
  final String img;
  final double width;
  final double height;
  final double circular;
  const CustomImageBox({
    required this.img, required this.width ,required this.height, required this.circular, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(circular),
        child: Image.asset(img,fit: BoxFit.fill,),
      ),
    );
  }
}
