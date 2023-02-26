import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:frontend/pages/confirm_booking.dart';
import 'package:intl/intl.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  TimeOfDay time = TimeOfDay(hour: 9, minute: 0);
  DateTime _selectedDate = DateTime.now();

  TextEditingController _textEdit = TextEditingController();

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
          child: Column(
        children: [
          bookingDate(),
          bookingTime(),
          location(),
          requirements(),
          bookButton(),
        ],
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
                print(_selectedDate.toString());
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
                    controller: _textEdit,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            pickTime();
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
                    controller: _textEdit,
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            pickTime();
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

  void pickTime() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      setState(() {
        time = value!;
        _textEdit.text = time.format(context).toString();
      });
    });
  }

  Widget location() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "End time",
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
              controller: _textEdit,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
            child: TextFormField(
              minLines: 6,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                fillColor: Colors.white,
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
                labelText: 'Your requirements for this service',
              ),
            ),
          ),
        ],
      ),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => confirmBooking()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => confirmBooking()));
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
