// ignore_for_file: prefer_const_constructors, use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/Services/CallAPI.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/Services/notification_services.dart';
import 'package:frontend/screens/auth/register/register.dart';
import 'package:frontend/provider/UserProvider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _isEmpty = false;
  CallApi obj = CallApi();

  User? activeUser;

  NotificationServices notificationServices = NotificationServices();

  
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.interactMessage(context);
    notificationServices.getDeviceToken().then((value) {
      print("token: $value");
    });
  }


 
  @override
  Widget build(BuildContext context) {
  final emailController = ref.watch(emailControllerProvider);
  final passwordController = ref.watch(passwordControllerProvider);


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Top section container
            Container(
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                      bottomRight: Radius.circular(90)),
                  color: new Color(0xffF5591F),
                  gradient: LinearGradient(colors: [
                    (new Color(0xffF5591F)),
                    (new Color(0xffF2861E))
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Image.asset("images/logo.png"),
                  height: 180,
                  width: 180,
                ),
              ),
            ),

            // login title
            Container(
              margin: EdgeInsets.only(top: 45),
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(230, 60, 58, 58),
                ),
              ),
            ),

            // Email field
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 40),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Email",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: new Color(0xffF2861E),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
            ),

            // Password field
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 20),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: _isEmpty == false
                              ? Colors.grey.shade200
                              : Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffF2861E),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
            ),

            //Forget password
            // Container(
            //   margin: EdgeInsets.only(top: 10, right: 35),
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //     child: Text(
            //       "Forgot Password?",
            //       style: TextStyle(
            //         color: Color(0xffF2861E),
            //       ),
            //     ),
            //     onTap: () {},
            //   ),
            // ),

            //login button
            Container(
              margin: EdgeInsets.only(top: 60),
              padding: EdgeInsets.only(left: 5, right: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xffF2861E),
                    minimumSize: Size(320, 55)),
                onPressed: () {
                
                },
                child: Text(
                  "LOGIN",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),

            //Register screen link
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Text(
                      " Register",
                      style: TextStyle(color: Color(0xffF2861E)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
