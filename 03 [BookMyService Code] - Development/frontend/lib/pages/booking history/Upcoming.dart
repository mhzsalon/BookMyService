// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpcommingBookings extends StatefulWidget {
  var uID;
  var type;
  UpcommingBookings({super.key, this.uID, this.type});

  @override
  State<UpcommingBookings> createState() => _UpcommingBookingsState();
}

class _UpcommingBookingsState extends State<UpcommingBookings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, right: 30, left: 30),
      child: Container(
        height: 135,
        padding: EdgeInsets.only(left: 25, top: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xffF4F0F0),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white38,
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("images/default-profile.png"))),
            ),
            const SizedBox(
              width: 25,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "John Walberg",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Cleaner",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "08:00 - 10:00 AM",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "2023-02-03",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black26,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
