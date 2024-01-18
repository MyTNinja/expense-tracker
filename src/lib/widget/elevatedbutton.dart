import 'package:firebaseconnection/mycolor/appcolor.dart';
import 'package:flutter/material.dart';

class ElevatedBtn extends StatelessWidget {
  ElevatedBtn({Key? key,
   required this.text,

    required this.onPressed,
    this.loading=false,

  }): super(key: key);


  final String text;
  final bool? loading;
 // ButtonStyle? style;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Center(child: loading! ? CircularProgressIndicator(strokeWidth: 3,color: MyColor.white,) :
            Text(text),
          // Text(   ''   , style: TextStyle(color: MyColor.white)
          // ),
          ),
          style: ButtonStyle(
      shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(40.0)),
      side: BorderSide(color: MyColor.blue),),),
          ),
      ),
    );
  }
}
