import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnection/login.dart';
import 'package:firebaseconnection/mycolor/appcolor.dart';
import 'package:firebaseconnection/utils/toastutils.dart';
import 'package:flutter/material.dart';


class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: MyColor.blue,
          title: Text("post"),
    actions: [

      IconButton(
        icon: Icon(Icons.logout,color: MyColor.darkwhite),
        onPressed: (){
          _auth.signOut().then((value) {

            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginForm()));

          }).onError((error, stackTrace) {
            Utils().toastMessage(error.toString());
          });


          },

      ),SizedBox(width: 30,),

    ]

    ),
    );
  }
}
