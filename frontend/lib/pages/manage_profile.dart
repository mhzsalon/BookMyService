import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/pages/login/login.dart';
import 'package:frontend/pages/notification.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool active = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 68,
      //   title: Padding(
      //     padding: const EdgeInsets.only(left: 69, top: 4),
      //     child: Text(
      //       "Manage Profile",
      //       style: TextStyle(fontWeight: FontWeight.bold),
      //     ),
      //   ),
      //   foregroundColor: Color(0xffF2861E),
      //   elevation: 0,
      // ),
      body: SafeArea(
        child: Column(children: <Widget>[
          // Container(
          //   margin: EdgeInsets.only(top: 25),
          //   color: Color(0xffFBFBFB),
          //   child: Text(
          //     "Manage Profile",
          //     style: TextStyle(
          //         fontWeight: FontWeight.bold,
          //         color: Color(0xffF2861E),
          //         fontSize: 20),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 80),
            child: CircleAvatar(
              radius: 60.0,
              backgroundImage: AssetImage("images/default-profile.png"),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 25),
            child: Text(
              "Salon Maharjan",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 3),
            child: Text(
              "mhrznsalon@gmail.com",
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 100, right: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xffF2861E),
                  minimumSize: Size(100, 50)),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  )
                ],
              ),
            ),
          ),

          // Profile settings
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(top: 55, left: 35, right: 35),
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(160, 238, 237, 237),
              ),
              child: Row(children: const <Widget>[
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.key,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Change Password",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ]),
            ),
          ),

          // Notification

          //Active
          Container(
            margin: EdgeInsets.only(top: 15, left: 35, right: 35),
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(160, 238, 237, 237),
            ),
            child: Row(children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Icon(
                Icons.account_circle_sharp,
                color: Colors.black54,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Active",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 130,
              ),
              Switch(
                value: active,
                activeColor: Colors.green,
                onChanged: (bool value) {
                  setState(() {
                    active = value;
                  });
                },
              ),
            ]),
          ),

          // logout
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 35, right: 35),
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(160, 238, 237, 237),
              ),
              child: Row(children: const <Widget>[
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.logout,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
