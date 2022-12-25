import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 3);
    return new Timer(duration, loginRoute);
  }

  loginRoute() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: new Color(0xffF5591F),
                  gradient: LinearGradient(colors: [
                    (new Color(0xffF5591F)),
                    (new Color(0xffF2861E))
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
          Center(
            child: Container(child: Image.asset("images/logo.png")),
          )
        ],
      ),
    );
  }
}
