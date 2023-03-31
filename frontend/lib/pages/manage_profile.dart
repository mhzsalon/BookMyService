// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/changePW.dart';
import 'package:frontend/editUser.dart';
import 'package:frontend/pages/login/login.dart';
import 'package:frontend/pages/notification.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  var id;
  var email;
  var name;
  var type;
  Profile({super.key, this.email, this.name, this.type, this.id});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool active = true;

  status(String id) async {
    Response response = await get(
      Uri.parse("http://10.0.2.2:8000/api/activate/?id=$id"),
    );
    var spDetail = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        active = spDetail['active_status'];
      });
      print(spDetail);
    }
  }

  activateUser(String id) async {
    Response response = await put(
      Uri.parse("http://10.0.2.2:8000/api/activate/?email=$id"),
    );
    var spDetail = jsonDecode(response.body.toString());
    print(spDetail['message']);
  }

  deactivateUser(String id) async {
    Response response = await put(
      Uri.parse("http://10.0.2.2:8000/api/deactivate/?email=$id"),
    );
    var spDetail = jsonDecode(response.body.toString());
    print(spDetail['message']);
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.type == 'Service Provider') {
      status(widget.id.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _name = widget.name;
    String _email = widget.email;
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
            margin: EdgeInsets.only(top: 15),
            child: Text(
              _name,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 3),
            child: Text(
              _email,
              style: TextStyle(
                  color: Colors.black45,
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditUser(
                              id: widget.id,
                              type: widget.type,
                            )));
              },
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

          // Change Password
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePW(id: widget.id)));
            },
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

          widget.type == "Service Provider"
              ?
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
                          active == true
                              ? activateUser(widget.id)
                              : deactivateUser(widget.id);
                        });
                      },
                    ),
                  ]),
                )
              : Container(),

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
