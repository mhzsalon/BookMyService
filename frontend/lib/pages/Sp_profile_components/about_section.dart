import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:frontend/pages/booking.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class aboutSection extends StatefulWidget {
  var email;
  var location;
  var phone;
  aboutSection({super.key, this.email, this.location, this.phone});

  @override
  State<aboutSection> createState() => _aboutSectionState();
}

class _aboutSectionState extends State<aboutSection> {
  @override
  Widget build(BuildContext context) {
    String? _number = widget.phone;
    String? _email = widget.email;
    String? _address = widget.location;

    var phone = Uri.parse("tel://$_number");
    var mail = Uri.parse("mailto:$_email");

    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 25, top: 20),
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
                        margin: EdgeInsets.only(bottom: 5),
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
                      _address == null ? "No location" : _address,
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
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type. ",
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookingScreen()));
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
