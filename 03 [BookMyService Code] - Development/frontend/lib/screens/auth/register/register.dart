// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/register/registration_forms/service_provider.dart';
import 'package:frontend/screens/auth/register/registration_forms/user.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int currentTab = 0;
  final List<Widget> screens = [User(), ServiceProvider()];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(90),
                    bottomRight: Radius.circular(90),
                  ),
                  color: new Color(0xffF5591F),
                  gradient: LinearGradient(colors: [
                    (new Color(0xffF5591F)),
                    (new Color(0xffF2861E))
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 40),
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                ),
              ),
            ),

            //Registration option
            Container(
              child: Column(
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.only(right: 15, left: 15),
                    margin: EdgeInsets.only(right: 40, left: 35, top: 30),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(80)),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center ,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                            minWidth: 130,
                            onPressed: () {
                              setState(() {
                                currentScreen = User();
                                currentTab = 0;
                              });
                            },
                            elevation: currentTab == 0 ? 2 : 0,
                            color: currentTab == 0
                                ? Color(0xffF2861E)
                                : Colors.grey[200],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "User",
                              style: TextStyle(
                                  color: currentTab == 0
                                      ? Colors.white
                                      : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                        MaterialButton(
                            minWidth: 110,
                            onPressed: () {
                              setState(() {
                                currentScreen = ServiceProvider();
                                currentTab = 1;
                              });
                            },
                            elevation: currentTab == 1 ? 2 : 0,
                            color: currentTab == 1
                                ? Color(0xffF2861E)
                                : Colors.grey[200],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: Text(
                              "Service Provider",
                              style: TextStyle(
                                  color: currentTab == 1
                                      ? Colors.white
                                      : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            PageStorage(bucket: bucket, child: currentScreen),
          ],
        ),
      ),
    );
  }
}
