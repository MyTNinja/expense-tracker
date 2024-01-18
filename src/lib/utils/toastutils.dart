import 'package:firebaseconnection/mycolor/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils{

  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor:MyColor.darkwhite,
        textColor: Colors.green,
        fontSize: 12.0
    );
  }
}
