import 'package:flutter/material.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: Image.asset(
              'images/splash.png',
              height: 200,
              width: 350,
            )),
            Text(
              "Welcome To BookMyService",
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontFamily: 'Source Sans Pro',
                letterSpacing: 2.5,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
