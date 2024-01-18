import 'package:firebaseconnection/login.dart';
import 'package:firebaseconnection/mycolor/appcolor.dart';
import 'package:firebaseconnection/utils/toastutils.dart';
import 'package:firebaseconnection/widget/container.dart';
import 'package:firebaseconnection/widget/elevatedbutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupForm extends StatefulWidget {
  SignupForm({super.key});


  @override
  State<SignupForm> createState() => _SignupFormState();
}
  final formkey = GlobalKey<FormState>();

  TextEditingController _signupNameController = TextEditingController();
  TextEditingController _signupPasswordController = TextEditingController();
  TextEditingController _signupEmailController = TextEditingController();
  TextEditingController _signupPhoneController = TextEditingController();
  TextEditingController _signupCNICController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;


class _SignupFormState extends State<SignupForm> {

  bool loading = false;

  void register(){
    setState(() {
      loading = true;
    });


    _auth.createUserWithEmailAndPassword(
        email: _signupEmailController.text.toString(),
        password:_signupPasswordController.text.toString()).then((value){
      setState(() {
        loading = false;
      });


    }).onError((error, stackTrace) {Utils().toastMessage(error.toString());
    setState(() {
      loading = false;
    });


    } );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Form',),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_new), onPressed: () {Navigator.pop(context);  },),
      ),
      body: Center(
        child: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(
              children: [
            Icon(Icons.assignment,size: 100,),
                SizedBox(height: 10,),

                Form(
                    key: formkey, child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _signupNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          labelText: 'Enter Name',
                          prefixIcon: Icon(Icons.people),
                          suffixIcon: Icon(Icons.drive_file_rename_outline),
                        ),
                        validator: (value){
                          if(value==null ||value.isEmpty){
                            return 'please enter the Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _signupEmailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.alternate_email),
                          suffixIcon: Icon(Icons.drive_file_rename_outline),
                        ),
                        validator: (value){
                          if(value==null ||value.isEmpty){
                            return 'please enter the Email';
                          }
                          return null;
                        },
                      ),

                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        controller: _signupPasswordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.password_rounded),
                          suffixIcon: Icon(Icons.drive_file_rename_outline),
                        ),
                        validator: (value){
                          if(value==null ||value.isEmpty){
                            return 'please enter the Password';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _signupPhoneController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          labelText: 'Contact',
                          prefixIcon: Icon(Icons.contact_mail),
                          suffixIcon: Icon(Icons.drive_file_rename_outline),
                        ),
                        validator: (value){
                          if(value==null ||value.isEmpty){
                            return 'please enter the contact number';
                          }
                          return null;
                        },
                      ),

                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _signupCNICController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          labelText: 'Employee ID',
                          prefixIcon: Icon(Icons.format_list_numbered_rtl),
                          suffixIcon: Icon(Icons.drive_file_rename_outline),
                        ),
                        validator: (value){
                          if(value==null ||value.isEmpty){
                            return 'please enter the ID Card number';
                          }
                          return null;
                        },
                      ),
                    ),

                  ],)),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedBtn(
                    text:'Register',
                      loading: loading,
                    onPressed: () {
                    if(formkey.currentState!.validate()){

                      register();
                    }

                   }
                  ),
                ),
              //  CustomContainer( MyColor.blue, 100, 100, Text("zeeshan")),
          ]
          ),
        ),
      ),
    );
  }
}

