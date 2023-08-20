// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:frontend/Services/CallAPI.dart';
import 'package:frontend/screens/booking%20history/booking%20history%20components/bookingDetails.dart';
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

  var paymentData;
  var mode = [];
  var ptype = [];

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
          "${obj.url}/booking/booking-history/?uid=$uid&user=$type&sp=$spId&time=previous"));
      if (res.statusCode == 200) {
        var details = jsonDecode(res.body.toString());
        print(details);
        setState(() {
          bookingData = details['booking'];
          paymentData = details['payment'];
          length = details['booking'].length;
          print(length);
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
        child: bookingData == null
            ? Center(child: Text("Loading..."))
            : Container(
                height: 650,
                child: length == 0
                    ? Center(child: Text("No bookings."))
                    : ListView.builder(
                        itemCount: length,
                        itemBuilder: (context, index) {
                          if (bookingData != null) {
                            // Retrieve the payment data for the current booking
                            var currentPaymentData = paymentData
                                .where((p) =>
                                    p['booking_id'] == bookingData[index]['id'])
                                .toList();
                            if (currentPaymentData.isNotEmpty) {
                              mode.add(currentPaymentData[0]['payment_mode']);
                              ptype.add(currentPaymentData[0]['is_paid']);
                            } else {
                              ptype.add(false);
                              mode.add("NA");
                            }
                          }
                          String imageURL = bookingData[index]['user_id']
                                  ['avatar']
                              .toString();
                          String spImage = bookingData[index]
                                      ['serviceProvider_id']['service_provider']
                                  ['avatar']
                              .toString();
                          return Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child: GestureDetector(
                              onTap: () {
                                if (bookingData != null) {}
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingDetails(
                                        date: bookingData[index]['serviceDate'],
                                        endTime: bookingData[index]['end_time'],
                                        startTime: bookingData[index]
                                            ['start_time'],
                                        location: bookingData[index]
                                            ['location'],
                                        price: bookingData[index]
                                            ['serviceProvider_id']['price'],
                                        totalPrice: bookingData[index]['price'],
                                        paymentStatus: ptype[index],
                                        paymentType: mode[index],
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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white38,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(widget.type ==
                                                      "Clients"
                                                  ? "${obj.url}$spImage"
                                                  : "${obj.url}$imageURL"))),
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (bookingData != null)
                                            Text(
                                              widget.type == "Clients"
                                                  ? bookingData[index][
                                                              'serviceProvider_id']
                                                          ['service_provider']
                                                      ['name']
                                                  : bookingData[index]
                                                      ['user_id']['name'],
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
                                              bookingData[index]
                                                      ['serviceProvider_id']
                                                  ['service'],
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
                                              "${bookingData[index]['start_time']} - ${bookingData[index]['end_time']}",
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
                                              bookingData[index]['serviceDate'],
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
