// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:frontend/API/CallAPI.dart';
import 'package:frontend/pages/MyBookings.dart';
import 'package:frontend/pages/home.dart';
import 'package:frontend/pages/notification.dart';
import 'package:frontend/pages/manage_profile.dart';

class LandingPage extends StatefulWidget {
  var id;
  var userAccess;
  var email;
  var name;

  LandingPage({super.key, this.userAccess, this.email, this.name, this.id});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;
  String? pushtoken;

  // void getToken() async {
  //   await FirebaseMessaging.instance.getToken().then((tkn) {
  //     setState(() {
  //       pushtoken = tkn;
  //     });

  //     saveToken(tkn!);
  //   });
  // }

  // void saveToken(String token) async {
  //   await FirebaseFirestore.instance
  //       .collection("UserTokens")
  //       .doc("user@gmail.com")
  //       .set({
  //     'token': token,
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    // getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  String a = "${widget.userAccess}";
    List<Widget> screen = [
      HomePage(
        userType: widget.userAccess,
        name: widget.name,
        uID: widget.id,
      ),
      MyBooking(),
      Profile(
        email: widget.email,
        name: widget.name,
        type: widget.userAccess,
        id: widget.id,
      ),
    ];
    return Scaffold(
      body: screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffEEF1F9),
        fixedColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'My Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
