import 'dart:convert';

import 'package:frontend/API/CallAPI.dart';
import 'package:frontend/pages/booking%20history/bookingDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class PreviousBookings extends StatefulWidget {
  var uid;
  var type;
  var spid;

  PreviousBookings({super.key, this.uid, this.type, this.spid});

  @override
  State<PreviousBookings> createState() => _PreviousBookingsState();
}

class _PreviousBookingsState extends State<PreviousBookings> {
  var bookingData;
  var length;

  CallApi obj = CallApi();

  @override
  void initState() {
    super.initState();
    getBookingDetails(
        widget.uid.toString(), widget.type.toString(), widget.spid.toString());
  }

  getBookingDetails(String uid, String type, String spId) async {
    try {
      Response res = await get(Uri.parse(
          "${obj.url}/booking/booking-history/?uid=$uid&user=$type&sp=$spId"));
      if (res.statusCode == 200) {
        var details = jsonDecode(res.body.toString());
        print(details);
        setState(() {
          bookingData = details;
          length = bookingData.length;
        });
      }
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30, right: 30, left: 30),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        reverse: true,
        child: Container(
          height: 700,
          child: ListView.builder(
            itemCount: length,
            itemBuilder: (context, index) {
              // if (bookingData != null) {
              //   DateTime inputDateTime = DateTime(
              //       bookingData[index]['serviceData'],
              //       bookingData[index][
              //           'start_time']); // replace with your input date and time

              //   bool isPastCurrentDateTime =
              //       inputDateTime.isBefore(DateTime.now());

              //   if (isPastCurrentDateTime) {
              //     print('The input date and time is in the past.');
              //   } else {
              //     print('The input date and time is not in the past.');
              //   }
              // }

              return Container(
                margin: EdgeInsets.only(bottom: 25),
                child: GestureDetector(
                  onTap: () {
                    if (bookingData != null) {}
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookingDetails(
                            date: bookingData['booking'][index]['serviceDate'],
                            endTime: bookingData['booking'][index]['end_time'],
                            startTime: bookingData['booking'][index]
                                ['start_time'],
                            location: bookingData['booking'][index]['location'],
                            price: bookingData['booking'][index]
                                ['serviceProvider_id']['price'],
                            totalPrice: bookingData['booking'][index]['price'],
                            paymentStatus: bookingData['payment'][index]
                                ['is_paid'],
                            paymentType: bookingData['payment'][index]
                                ['payment_mode'],
                          ),
                        ));
                  },
                  child: Container(
                    height: 135,
                    padding: EdgeInsets.only(left: 25, top: 25),
                    // margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffF4F0F0),
                    ),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 25),
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      "images/default-profile.png"))),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (bookingData != null)
                                Text(
                                  bookingData['booking'][index]
                                          ['serviceProvider_id']
                                      ['service_provider']['name'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45,
                                  ),
                                ),
                              SizedBox(
                                height: 5,
                              ),
                              if (bookingData != null)
                                Text(
                                  bookingData['booking'][index]
                                      ['serviceProvider_id']['service'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black26,
                                  ),
                                ),
                              SizedBox(
                                height: 5,
                              ),
                              if (bookingData != null)
                                Text(
                                  "${bookingData['booking'][index]['start_time']} - ${bookingData['booking'][index]['end_time']}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black26,
                                  ),
                                ),
                              SizedBox(
                                height: 5,
                              ),
                              if (bookingData != null)
                                Text(
                                  bookingData['booking'][index]['serviceDate'],
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
