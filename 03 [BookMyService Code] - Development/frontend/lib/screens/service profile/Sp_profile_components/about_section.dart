// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:frontend/screens/booking/booking.dart';
import 'package:url_launcher/url_launcher.dart';

class aboutSection extends StatefulWidget {
  var uID;
  var spID;
  var email;
  var location;
  var phone;
  var price;
  var desciption;
  var name;
  var usertype;
  var mapData;
  var length;
  var service;
  aboutSection(
      {super.key,
      this.email,
      this.location,
      this.phone,
      this.name,
      this.usertype,
      this.uID,
      this.spID,
      this.price,
      this.desciption,
      this.length,
      this.mapData,
      this.service});

  @override
  State<aboutSection> createState() => _aboutSectionState();
}

class _aboutSectionState extends State<aboutSection> {
  @override
  Widget build(BuildContext context) {
    print(widget.desciption);
    String? number = widget.phone;
    String? email = widget.email;
    String? address = widget.location;
    String? description = widget.desciption;

    var phone = Uri.parse("tel://$number");
    var mail = Uri.parse("mailto:$email");

    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 25, top: 20),
            child: Row(children: <Widget>[
              //Phone call
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    // FlutterPhoneDirectCaller.callNumber('+977015540584');
                    launchUrl(phone);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(67, 180, 245, 97)),
                        child: Icon(
                          Icons.call,
                          color: Color(0xff5FEE08),
                          size: 30,
                        ),
                      ),
                      Text(
                        "Phone",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                          color: Colors.black54,
                        ),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ),

              //Email
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    // FlutterPhoneDirectCaller.callNumber('+977015540584');
                    launchUrl(mail);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color.fromARGB(67, 242, 86, 86)),
                        child: Icon(
                          Icons.email,
                          color: Color(0xffF25656),
                          size: 30,
                        ),
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //location
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(67, 99, 103, 93)),
                      child: Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Text(
                      address ?? "No location",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        height: 1.4,
                        color: Colors.black54,
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
          Text(
            description ?? "No description.",
            style: TextStyle(
              fontSize: 16,
              height: 1.4,
              color: Colors.black54,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: FloatingActionButton.extended(
              onPressed: () {
                // Add your onPressed code here!
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookingScreen(
                            name: widget.name,
                            usertype: widget.usertype,
                            uID: widget.uID,
                            spID: widget.spID,
                            price: widget.price,
                            mapData: widget.mapData,
                            length: widget.length,
                            service: widget.service)));
              },
              label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  "Book now",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              backgroundColor: Color(0xffF2861E),
            ),
          ),
        ],
      ),
    );
  }
}
