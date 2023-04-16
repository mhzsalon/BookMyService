import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/pages/Sp_profile_components/about_section.dart';
import 'package:frontend/pages/Sp_profile_components/review_section.dart';
import 'package:http/http.dart';
import 'package:tab_container/tab_container.dart';

class SP_profile extends StatefulWidget {
  var uID;
  var id;
  var service;
  var spName;
  var email;
  var contact;
  var location;
  var price;
  var description;
  var name;
  var usertype;

  SP_profile(
      {super.key,
      this.name,
      this.usertype,
      this.price,
      this.uID,
      this.id,
      this.service,
      this.contact,
      this.email,
      this.spName,
      this.location,
      this.description});

  @override
  State<SP_profile> createState() => _SP_profileState();
}

class _SP_profileState extends State<SP_profile> {
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = aboutSection();
  final List<Widget> screens = [aboutSection(), reviewSection()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEF1F9),
      appBar: AppBar(
        toolbarHeight: 68,
        title: const Padding(
          padding: EdgeInsets.only(left: 100, top: 4),
          child: Text(
            "Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff3C3A3A)),
          ),
        ),
        backgroundColor: Color(0xffEEF1F9),
        foregroundColor: Color(0xffF2861E),
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          top(),
          Container(
            padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    //About
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentScreen = aboutSection(
                            email: widget.email,
                            phone: widget.contact,
                            location: widget.location,
                            desciption: widget.description,
                          );
                          currentTab = 0;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        alignment: Alignment.center,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: currentTab == 0
                                  ? Color(0xffF2861E)
                                  : Color(0xffEEF1F9),
                              width: 6.0,
                            ),
                          ),
                        ),
                        child: Text(
                          "About",
                          style: TextStyle(
                              fontSize: currentTab == 0 ? 20 : 16,
                              color: currentTab == 0
                                  ? Color(0xffF2861E)
                                  : Colors.black38,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    // Review
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentScreen = reviewSection();
                          currentTab = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        alignment: Alignment.center,
                        width: 120,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: currentTab == 1
                                  ? Color(0xffF2861E)
                                  : Color(0xffEEF1F9),
                              width: 6.0,
                            ),
                          ),
                        ),
                        child: Text(
                          "Review",
                          style: TextStyle(
                              fontSize: currentTab == 1 ? 20 : 16,
                              color: currentTab == 1
                                  ? Color(0xffF2861E)
                                  : Colors.black38,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ],
                ),
                PageStorage(
                    bucket: bucket,
                    child: currentTab == 0
                        ? aboutSection(
                            email: widget.email,
                            phone: widget.contact,
                            location: widget.location,
                            uID: widget.uID,
                            spID: widget.id,
                            price: widget.price,
                            desciption: widget.description,
                            name: widget.name,
                            usertype: widget.usertype,
                          )
                        : reviewSection(
                            id: widget.id,
                            uID: widget.uID,
                          )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget top() {
    String? _name = widget.spName;
    String? _service = widget.service;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 90, right: 30, left: 30),
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: new Color(0xffF5591F),
            gradient: LinearGradient(
                colors: [(new Color(0xffF5591F)), (new Color(0xffF2861E))],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _name!,
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          _service!,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(233, 255, 255, 255),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 72,
            child: CircleAvatar(
              backgroundImage: AssetImage("images/default-profile.png"),
              radius: 67,
            ),
          ),
        )
      ],
    );
  }

  // Widget content0() {
  //   return Container(
  //     padding: EdgeInsets.only(top: 50, left: 30, right: 30),
  //     child: Column(
  //       children: [
  //         Row(
  //           children: <Widget>[
  //             //About
  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   currentScreen = aboutSection(
  //                     email: widget.email,
  //                     phone: widget.contact,
  //                     location: widget.location,
  //                   );
  //                   currentTab = 0;
  //                 });
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.only(bottom: 5),
  //                 alignment: Alignment.center,
  //                 width: 120,
  //                 decoration: BoxDecoration(
  //                   border: Border(
  //                     bottom: BorderSide(
  //                       color: currentTab == 0
  //                           ? Color(0xffF2861E)
  //                           : Color(0xffEEF1F9),
  //                       width: 6.0,
  //                     ),
  //                   ),
  //                 ),
  //                 child: Text(
  //                   "About",
  //                   style: TextStyle(
  //                       fontSize: currentTab == 0 ? 20 : 16,
  //                       color: currentTab == 0
  //                           ? Color(0xffF2861E)
  //                           : Colors.black38,
  //                       fontWeight: FontWeight.w500,
  //                       letterSpacing: 1),
  //                 ),
  //               ),
  //             ),
  //             SizedBox(
  //               width: 5,
  //             ),
  //             // Review
  //             GestureDetector(
  //               onTap: () {
  //                 setState(() {
  //                   currentScreen = reviewSection();
  //                   currentTab = 1;
  //                 });
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.only(bottom: 5),
  //                 alignment: Alignment.center,
  //                 width: 120,
  //                 decoration: BoxDecoration(
  //                   border: Border(
  //                     bottom: BorderSide(
  //                       color: currentTab == 1
  //                           ? Color(0xffF2861E)
  //                           : Color(0xffEEF1F9),
  //                       width: 6.0,
  //                     ),
  //                   ),
  //                 ),
  //                 child: Text(
  //                   "Review",
  //                   style: TextStyle(
  //                       fontSize: currentTab == 1 ? 20 : 16,
  //                       color: currentTab == 1
  //                           ? Color(0xffF2861E)
  //                           : Colors.black38,
  //                       fontWeight: FontWeight.w500,
  //                       letterSpacing: 1),
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         PageStorage(bucket: bucket, child: currentScreen),
  //       ],
  //     ),
  //   );
  // }
}
