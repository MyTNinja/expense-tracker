import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnection/expenses.dart';
import 'package:firebaseconnection/post.dart';
import 'package:flutter/material.dart';

import '../login.dart';

class SplashService{

  void isLogin(BuildContext context){


    final _auth = FirebaseAuth.instance; //for authentication purpose
    final user = _auth.currentUser;       //if user _auth
        //if user is already login go to the post screen else go to the loginscreen condition.
       if (user!=null) {
         Timer(const Duration(seconds: 2),
                 () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Expenses()))
         );
       }
       else{
         Timer(Duration(seconds: 2),
                 () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginForm()))
         );
       }



    // Timer(Duration(seconds: 2),
    //         () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginForm()))
    // );

  }
}