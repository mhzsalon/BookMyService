// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:frontend/screens/service%20profile/Sp_profile_components/about_section.dart';
import 'package:frontend/screens/service%20profile/Sp_profile_components/review_section.dart';

import '../../Services/CallAPI.dart';

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
  var image;
  var trend;
  var mapData;
  var length;

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
      this.description,
      this.image,
      this.trend,
      this.length,
      this.mapData});

  @override
  State<SP_profile> createState() => _SP_profileState();
}

class _SP_profileState extends State<SP_profile> {
  CallApi obj = CallApi();
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = aboutSection();
  final List<Widget> screens = [aboutSection(), reviewSection()];

  @override
  Widget build(BuildContext context) {
    print(widget.description);
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
                            uID: widget.uID.toString(),
                            spID: widget.id.toString(),
                            price: widget.price,
                            desciption: widget.description,
                            name: widget.name,
                            usertype: widget.usertype,
                            mapData: widget.mapData,
                            length: widget.length,
                            service: widget.service,
                          )
                        : reviewSection(
                            id: widget.id.toString(),
                            uID: widget.uID.toString(),
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
    String imageURL = widget.image.toString();
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
            child:
                // CircleAvatar(
                //   backgroundImage: NetworkImage(widget.image == null
                //       ? "${obj.url}$imageURL"
                //       : "https://www.google.com/url?sa=i&url=https%3A%2F%2Fstock.adobe.com%2Fsearch%2Fimages%3Fk%3Ddefault%2Bprofile%2Bpicture&psig=AOvVaw3A2QfovSgQqdoHAfv2zELY&ust=1684925102438000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCLi1j6Shi_8CFQAAAAAdAAAAABAJ"),
                //   radius: 67,
                // ),

                CircleAvatar(
              backgroundImage: NetworkImage(
                  widget.trend == false ? "${obj.url}$imageURL" : "$imageURL"),
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
