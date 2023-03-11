import 'package:flutter/material.dart';
import 'package:frontend/pages/MyBookings.dart';
import 'package:frontend/pages/home.dart';
import 'package:frontend/pages/notification.dart';
import 'package:frontend/pages/manage_profile.dart';

class LandingPage extends StatefulWidget {
  var userAccess;

  LandingPage({super.key,  this.userAccess});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;
  // String a = "${widget.userAccess}";
  // List<Widget> screen = [
  //   // HomePage(userType: widget.userAccess),
  //   MyBooking(),
  //   Profile(),
  // ];
  @override
  Widget build(BuildContext context) {
    //  String a = "${widget.userAccess}";
    List<Widget> screen = [
      HomePage(userType: widget.userAccess),
      MyBooking(),
      Profile(),
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
