
import 'package:firebaseconnection/splashscreen/SplashClass.dart';
import 'package:flutter/material.dart';




class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
SplashService splashScreen = SplashService();

  @override
  void initState() {
    super.initState();
    splashScreen.isLogin(context);

    // Timer(Duration(seconds: 2),
    //         () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginForm()))
    // );
  }


  @override
  Widget build(BuildContext context) {
    return Container(height: 50,

        child: Image.asset('assets/images/flutterlogo.png',));
  }
}
