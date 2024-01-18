import 'package:firebaseconnection/mycolor/appcolor.dart';
import 'package:flutter/material.dart';


class CustomContainer extends StatelessWidget {
  CustomContainer(
  this.borderRadius,
   this.color,
   this.width,
  this.height,
   this.child,

      {super.key, });

  Color? color;
  final double? width;
  final double? height;
  final Widget? child;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, width: width,
      decoration: BoxDecoration(
        color: color ?? MyColor.blue,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius!)),
      ),
      child: child,



    );
  }
}


