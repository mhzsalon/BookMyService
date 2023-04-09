import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:frontend/API/CallAPI.dart';
import 'package:frontend/pages/confirm_booking.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class BookingScreen extends StatefulWidget {
  var uID;
  var spID;
  final double price;
  BookingScreen({super.key, this.spID, this.uID, required this.price});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TimeOfDay time = TimeOfDay(hour: 9, minute: 0);
  DateTime _selectedDate = DateTime.now();
  String formattedDate = '';
  TextEditingController _textEdit = TextEditingController();
  TextEditingController _startTime = TextEditingController();
  TextEditingController _endTime = TextEditingController();

  TextEditingController _location = TextEditingController();
  TextEditingController _requirements = TextEditingController();

  // DateTime endTime = DateTime.now().add(Duration(hours: 2));
  CallApi obj = CallApi();
  TimeOfDay? st;
  TimeOfDay? ed;
  // int? totalHours;

  bookService(String spID, String uID, double price) async {
    DateTime startTime = DateTime(2023, 4, 3, st!.hour, st!.minute);
    DateTime endTime = DateTime(2023, 4, 3, ed!.hour, ed!.minute);
    Duration difference = endTime.difference(startTime);
    String formattedST = DateFormat('HH:mm:ss').format(startTime);
    String formattedET = DateFormat('HH:mm:ss').format(endTime);

    int totalHours = difference.inHours;
    double totalPrice = totalHours * price;
    print(totalPrice);
    debugPrint(formattedET);
    try {
      print('called');
      Response _response = await post(
        Uri.parse(obj.url + "/booking/book-service/"),
        body: {
          'id': uID,
          'sp_id': spID,
          'serviceDate': DateFormat('yyyy-MM-dd').format(_selectedDate),
          'location': _location.text.toString(),
          'price': '$totalPrice',
          'start_time': '$formattedST',
          'end_time': '$formattedET',
          'requirements': _requirements.text.toString(),
        },
      );
      var msg = jsonDecode(_response.body.toString());
      print(msg);

      if (_response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: msg['message'],
          buttonsTextStyle: const TextStyle(color: Colors.black),
          showCloseIcon: true,
          btnOkOnPress: () {
            setState(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => confirmBooking(
                            uID: uID,
                            price: price,
                            totalHours: totalHours,
                          )));
            });
          },
        ).show();
      } else if (_response.statusCode == 306) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Error',
          desc: msg['message'],
          buttonsTextStyle: const TextStyle(color: Colors.black),
          showCloseIcon: true,
          btnOkOnPress: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => this.widget));
          },
        ).show();
      }
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEF1F9),
      appBar: AppBar(
        toolbarHeight: 68,
        title: Padding(
          padding: const EdgeInsets.only(left: 80, top: 4),
          child: Text(
            "Booking",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
        ),
        backgroundColor: Color(0xffEEF1F9),
        foregroundColor: Color(0xffF2861E),
        elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            bookingDate(),
            bookingTime(),
            location(),
            requirements(),
            bookButton(),
          ],
        ),
      )),
    );
  }

  Widget bookingDate() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(top: 30, left: 25),
          child: Text(
            "Select Date",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 20),
          child: DatePicker(
            DateTime.now(),
            width: 70,
            height: 100,
            initialSelectedDate: DateTime.now(),
            selectedTextColor: Colors.white,
            selectionColor: Colors.orangeAccent,
            dateTextStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            dayTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            monthTextStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            onDateChange: ((newDate) {
              setState(() {
                _selectedDate = newDate;
                formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
                print(formattedDate);
              });
            }),
          ),
        ),
      ],
    );
  }

  Widget bookingTime() {
    String current_time = DateFormat.jm().format(DateTime.now());
    return Container(
      margin: EdgeInsets.only(left: 25, right: 30, top: 35),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Start time",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              Expanded(
                child: Text(
                  "End time",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  // margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _startTime,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            pickTime(_startTime, true);
                          },
                          icon: Icon(
                            Icons.access_time,
                          ),
                        ),
                        hintText: current_time,
                        hintStyle: TextStyle(
                          color: Colors.black45,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true),
                  ),
                ),
              ),
              const SizedBox(width: 40),
              Expanded(
                child: Container(
                  height: 50,
                  // margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _endTime,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            pickTime(_endTime, false);
                          },
                          icon: Icon(
                            Icons.access_time,
                          ),
                        ),
                        hintText: current_time,
                        hintStyle: TextStyle(
                          color: Colors.black45,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        filled: true),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // void pickTime() {
  //   showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   ).then((value) {

  //     setState(() {
  //       time = value!;
  //       // DateTime endDate =
  //       //     DateFormat("hh:mm").parse(time.format(context).toString());
  //       // _textEdit = endDate as TextEditingController;
  //       // print("-------------");
  //       // print(endDate);
  //       // print("-------------");
  //       print(time);
  //     });
  //   });
  // }
  Future<void> pickTime(TextEditingController controller, bool start) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (selectedTime != null && selectedTime != time) {
      setState(() {
        time = selectedTime;
        controller.text = time.format(context);
        start == true ? st = time : ed = time;
      });
    }
  }

  Widget location() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            alignment: Alignment.center,
            child: TextField(
              controller: _location,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_on,
                    ),
                  ),
                  hintText: "Location",
                  hintStyle: TextStyle(
                    color: Colors.black45,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Color.fromARGB(255, 255, 255, 255),
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }

  Widget requirements() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: 35),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Requirements",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.white,
          height: 150,
          child: TextField(
            minLines: 6,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              fillColor: Colors.white,
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
              hintText: 'Your requirements for this service',
            ),
          ),
        ),
      ]),
    );
  }

  Widget bookButton() {
    return Container(
      margin: EdgeInsets.only(top: 20, right: 25, left: 25),
      padding: EdgeInsets.only(left: 5, right: 5),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xffF2861E),
                  minimumSize: Size(120, 50)),
              onPressed: () {
                // bookService(widget.spID.toString(), widget.uID.toString(),
                //     widget.price);
                Navigator.pop(context);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => confirmBooking()));
              },
              child: Text(
                "Cancel",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xffF2861E),
                  minimumSize: Size(200, 50)),
              onPressed: () {
                bookService(widget.spID.toString(), widget.uID.toString(),
                    widget.price);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => confirmBooking()));
              },
              child: Text(
                "Book now",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
