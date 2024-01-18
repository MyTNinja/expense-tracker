import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnection/main.dart';
import 'package:firebaseconnection/mycolor/appcolor.dart';
import 'package:firebaseconnection/post.dart';
import 'package:firebaseconnection/signup.dart';
import 'package:firebaseconnection/utils/toastutils.dart';
import 'package:firebaseconnection/widget/elevatedbutton.dart';
import 'package:firebaseconnection/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});


  @override
  State<LoginForm> createState() => _LoginFormState();
}
bool loading  = false;
String _title = 'Login Form';
//
final formkey=GlobalKey<FormState>();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();


class _LoginFormState extends State<LoginForm> {

   final _auth=FirebaseAuth.instance;

   void login(){

     setState(() {
       loading = true;
     });


     _auth.signInWithEmailAndPassword(
         email: emailController.text.toString(),
         password: passwordController.text.toString()).then((value){
          Utils().toastMessage(value.user!.email.toString() );

          Navigator.push(context , MaterialPageRoute(builder: (context) => Expenses())
          );
          setState(() {
            loading = false;
          });

     }).onError((error, stackTrace){
       debugPrint(error.toString());
       //for show exception

       Utils().toastMessage(error.toString());

       setState(() {
         loading = false;
       });
     });
   }

  @override         //dispose function is used to relase the memory when again signup.
  void dispose() {
    // TODO: implement dispose
     emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()  async{
        SystemNavigator.pop();
        return true;
      },

      child: Scaffold(
          // appBar: AppBar(title:Text(_title)),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Track Your Expenses',
                      style: TextStyle(
                          color: Colors.purple,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                // Container(
                //     alignment: Alignment.center,
                //     padding: const EdgeInsets.all(10),
                //     child: const Text(
                //       'Sign in',
                //       style: TextStyle(fontSize: 20),
                //     )),
                 Form(
                     key: formkey,
                 child: Column(children: [
                   Container(
                     padding: const EdgeInsets.all(10),
                     child: TextFormField(keyboardType: TextInputType.emailAddress ,
                       controller: emailController,
                       decoration: const InputDecoration(
                         border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                         labelText: 'Email',
                         prefixIcon: Icon(Icons.people),
                         suffixIcon: Icon(Icons.drive_file_rename_outline),
                       ),
                        validator: (value){
                         if(value==null ||value.isEmpty){
                           return 'please enter the valid Email';
                         }
                         return null;
                        },
                     ),

                   ),

                   Container(
                     padding: const EdgeInsets.all(10),
                     child: TextFormField(
                       keyboardType: TextInputType.text ,
                       obscureText: true,
                       controller: passwordController,
                       decoration: const InputDecoration(
                           border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                           labelText: 'Password',
                           prefixIcon: Icon(Icons.password),
                           suffixIcon: Icon(Icons.remove_red_eye_outlined)
                       ),
                       validator: (value){
                         if(value==null ||value.isEmpty){
                           return 'please enter the valid password';
                         }
                         return null;
                       },
                     ),
                   ),
                 ]),
                 ),

                TextButton(
                  onPressed: () {
                    //forgot password screen
                  },
                  child: const Text('Forgot Password',),
                ),
                SizedBox(height: 30,),
                ElevatedBtn(
                  loading: loading,
                  text:'Login',
                 // child: Text('Login',style: TextStyle(color: MyColor.white,fontSize: 20.0)),
                  onPressed: () {
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen(),));
                     if(formkey.currentState!.validate()){
                       login();
                     }

                  },
                ),
                SizedBox(height: 30,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Does not have account?'),
                    TextButton(
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupForm()));
                      },
                    )
                  ],

                ),
              ],
            )
        )
      ),
    );
  }
}
