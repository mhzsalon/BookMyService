// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/API/CallAPI.dart';
import 'package:frontend/pages/MyBookings.dart';
import 'package:frontend/pages/home.dart';
import 'package:frontend/pages/notification.dart';
import 'package:frontend/pages/manage_profile.dart';
import 'package:http/http.dart';

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
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    //  String a = "${widget.userAccess}";
    List<Widget> screen = [
      HomePage(
        userType: widget.userAccess,
        name: widget.name,
        uID: widget.id,
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
