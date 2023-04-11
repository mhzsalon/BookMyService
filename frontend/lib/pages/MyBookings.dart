import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:frontend/pages/booking%20history/Previous.dart';
import 'package:frontend/pages/booking%20history/Upcoming.dart';
import 'package:frontend/pages/confirm_booking.dart';
import 'package:intl/intl.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  int currentTab = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const UpcommingBookings();
  final List<Widget> screens = const [UpcommingBookings(), PreviousBookings()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            Row(
              children: <Widget>[
                //About
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentScreen = const UpcommingBookings();
                      currentTab = 0;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 5),
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
                      currentScreen = const PreviousBookings();
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
                  ? const UpcommingBookings()
                  : const PreviousBookings(),
            ),
          ],
        ),
      ),
    );
  }
}
