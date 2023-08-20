// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:frontend/screens/booking%20history/MyBookings.dart';
import 'package:frontend/screens/home_screen/home.dart';
import 'package:frontend/screens/user_settings/manage_profile.dart';

class LandingPage extends StatefulWidget {
  var id;
  var userAccess;
  var email;
  var name;
  var avatar;

  LandingPage(
      {super.key,
      this.userAccess,
      this.email,
      this.name,
      this.id,
      this.avatar});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    //  String a = "${widget.userAccess}";
    List<Widget> screen = [
      HomePage(
        userType: widget.userAccess,
        name: widget.name,
        uID: widget.id,
        avatar: widget.avatar,
      ),
      MyBooking(
        uID: widget.id,
        userType: widget.userAccess,
      ),
      Profile(
        email: widget.email,
        name: widget.name,
        type: widget.userAccess,
        id: widget.id,
        avatar: widget.avatar,
      ),
    ];
    return Scaffold(
      body: screen[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffEEF1F9),
        fixedColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
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
