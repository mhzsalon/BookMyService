// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/Services/CallAPI.dart';
import 'package:frontend/screens/booking%20history/booking%20history%20components/Previous.dart';
import 'package:frontend/screens/booking%20history/booking%20history%20components/Upcoming.dart';
import 'package:http/http.dart';

class MyBooking extends StatefulWidget {
  var userType;
  var uID;
  MyBooking({super.key, this.uID, this.userType});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  CallApi obj = CallApi();

  var bookingData;
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = UpcommingBookings();
  final List<Widget> screens = [UpcommingBookings(), PreviousBookings()];

  var spID;

  getSPID(String id) async {
    Response res = await get(
      Uri.parse("${obj.url}/service/payment/?id=$id"),
    );
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      setState(() {
        spID = data['id'];
        print(spID);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.userType == "Service Provider") {
      getSPID(widget.uID.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Title appbar
              Container(
                margin: EdgeInsets.only(top: 25),
                color: Color(0xffFBFBFB),
                child: const Text(
                  "Booking History",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xffF2861E),
                      fontSize: 20),
                ),
              ),

              // Page switching option
              Container(
                margin: const EdgeInsets.only(
                  top: 40,
                ),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //About
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          currentScreen = UpcommingBookings(
                            uid: widget.uID,
                            type: widget.userType,
                            spid: spID,
                          );
                          currentTab = 0;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 5),
                        alignment: Alignment.center,
                        width: 170,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: currentTab == 0
                                  ? Colors.orangeAccent
                                  : Color(0xffFBFBFB),
                              width: 5.0,
                            ),
                          ),
                        ),
                        child: Text(
                          "Upcoming",
                          style: TextStyle(
                              fontSize: currentTab == 0 ? 16 : 14,
                              color: currentTab == 0
                                  ? Colors.orangeAccent
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
                          currentScreen = PreviousBookings();
                          currentTab = 1;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5),
                        alignment: Alignment.center,
                        width: 170,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: currentTab == 1
                                  ? Colors.orangeAccent
                                  : Color(0xffFBFBFB),
                              width: 6.0,
                            ),
                          ),
                        ),
                        child: Text(
                          "Previous",
                          style: TextStyle(
                              fontSize: currentTab == 1 ? 16 : 14,
                              color: currentTab == 1
                                  ? Colors.orangeAccent
                                  : Colors.black38,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              PageStorage(
                bucket: bucket,
                child: currentTab == 0
                    ? UpcommingBookings(
                        uid: widget.uID,
                        type: widget.userType,
                        spid: spID,
                      )
                    : PreviousBookings(
                        uid: widget.uID,
                        type: widget.userType,
                        spid: spID,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
