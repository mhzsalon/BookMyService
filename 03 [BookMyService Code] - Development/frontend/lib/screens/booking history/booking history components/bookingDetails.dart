// ignore_for_file: must_be_immutable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:frontend/Services/CallAPI.dart';
import 'package:http/http.dart';

class BookingDetails extends StatefulWidget {
  var date;
  var startTime;
  var endTime;
  var price;
  var totalPrice;
  var paymentType;
  var paymentStatus;
  var location;
  var bID;
  var userAccess;

  BookingDetails({
    Key? key,
    this.date,
    this.startTime,
    this.paymentStatus,
    this.endTime,
    this.paymentType,
    this.price,
    this.totalPrice,
    this.location,
    this.bID,
    this.userAccess,
  }) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  CallApi obj = CallApi();

  updatePayment(String id) async {
    Response res = await put(
      Uri.parse("${obj.url}/service/payment/?id=$id"),
    );
    if (res.statusCode == 200) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Success',
        desc: 'Payment Confirmed.',
        buttonsTextStyle: const TextStyle(color: Colors.black),
        showCloseIcon: true,
        btnOkOnPress: () {
          setState(() {
            Navigator.pop(context);
          });
        },
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.userAccess);
    print(widget.paymentStatus);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF2861E),
        title: const Text(
          "Booking Details",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 275,
            padding: EdgeInsets.only(left: 25, top: 35),
            margin: EdgeInsets.only(left: 25, right: 25, top: 35),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffF4F0F0),
            ),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Location: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Price: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Time: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Payment type: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Total amount: ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.date?.toString() ?? 'N/A',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.location?.toString() ?? 'N/A',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Rs. ${widget.price?.toString() ?? 'N/A'}/hr ",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${widget.startTime?.toString() ?? 'N/A'} - ${widget.endTime?.toString() ?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.paymentType?.toString() ?? 'N/A',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          widget.totalPrice?.toString() ?? 'N/A',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 205, top: 30),
                  alignment: Alignment.center,
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    color: widget.paymentStatus == true
                        ? Color.fromARGB(67, 180, 245, 97)
                        : Color.fromARGB(67, 242, 86, 86),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.paymentStatus == true ? "Paid" : "Unpaid",
                    style: TextStyle(
                      color: widget.paymentStatus == true
                          ? Color(0xff5FEE08)
                          : Color(0xffF25656),
                    ),
                  ),
                )
              ],
            ),
          ),
          if (widget.userAccess == "Service Provider" &&
              widget.paymentStatus == false)
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.only(left: 5, right: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.orangeAccent,
                    minimumSize: Size(120, 50)),
                onPressed: () {
                  updatePayment(widget.bID.toString());
                },
                child: Text(
                  "PAY",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
