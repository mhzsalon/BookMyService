import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEF1F9),
      appBar: AppBar(
        toolbarHeight: 68,
        title: Padding(
          padding: const EdgeInsets.only(left: 69, top: 4),
          child: Text(
            "Notifications",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xffEEF1F9),
        foregroundColor: Color(0xffF2861E),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 25, left: 35, right: 35),
            padding: EdgeInsets.only(top: 15, right: 20),
            height: 110,
            width: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(203, 255, 255, 255),
            ),
            child: Column(
              children: <Widget>[
                //notification title
                Container(
                  margin: EdgeInsets.only(right: 200),
                  child: Text(
                    "Booking",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                // message
                Container(
                  margin: EdgeInsets.only(right: 40, top: 5),
                  child: Text(
                    "Your booking has been confirmed.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black45,
                    ),
                  ),
                ),

                //created time
                Container(
                  margin: EdgeInsets.only(top: 22, right: 210),
                  child: Text(
                    "2 min ago",
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
