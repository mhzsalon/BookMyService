// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/Services/CallAPI.dart';
import 'package:frontend/screens/service%20profile/sp_profile.dart';
import 'package:http/http.dart';

class TrendingSP extends StatefulWidget {
  var uID;
  var usertype;
  var name;
  TrendingSP({super.key, this.uID, this.name, this.usertype});

  @override
  State<TrendingSP> createState() => _TrendingSPState();
}

class _TrendingSPState extends State<TrendingSP> {
  CallApi obj = CallApi();

  var spData;
  var length;

  randomSP() async {
    int num = Random().nextInt(2) + 1;
    Response response = await get(
      Uri.parse("${obj.url}/api/home-screen/?page=$num"),
    );

    var sp = jsonDecode(response.body.toString());
    setState(() {
      spData = sp;
      length = spData['results'].length;
      print(spData);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    randomSP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
        left: 25,
        right: 25,
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 20,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              "Service Providers",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            child: SingleChildScrollView(
              child: spData == null
                  ? Text("Loading...")
                  : Container(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: length,
                          itemBuilder: (context, index) {
                            var pp = spData['results'][index]['price'];
                            String imageURL = spData['results'][index]
                                    ['service_provider']['avatar']
                                .toString();
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SP_profile(
                                                contact: spData['results']
                                                            [index]
                                                        ['service_provider']
                                                    ['phone'],
                                                description: spData['results']
                                                                [index]
                                                            ['description'] ==
                                                        ""
                                                    ? null
                                                    : spData['results'][index]
                                                        ['description'],
                                                email: spData['results'][index]
                                                        ['service_provider']
                                                    ['email'],
                                                image: imageURL,
                                                location: spData['results']
                                                            [index]
                                                        ['service_provider']
                                                    ['location'],
                                                name: widget.name,
                                                price: pp,
                                                service: spData['results']
                                                    [index]['service'],
                                                spName: spData['results'][index]
                                                        ['service_provider']
                                                    ['name'],
                                                id: spData['results'][index]
                                                    ['id'],
                                                uID: widget.uID,
                                                usertype: widget.usertype,
                                                trend: "true",
                                              )));
                                  // builder: (context) => CandidateProfile()));
                                },
                                child: Row(
                                  children: [
                                    // Image section
                                    Container(
                                      width: 120,
                                      height: 120,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white38,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage("$imageURL"),
                                        ),
                                      ),
                                    ),
                                    // Text section
                                    Expanded(
                                      child: Container(
                                        height: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              bottomRight: Radius.circular(20)),
                                          color: Colors.white,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 15,
                                              left: 15,
                                              right: 10,
                                              bottom: 10),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        spData['results'][index]
                                                                [
                                                                'service_provider']
                                                            ['name'],
                                                        style: TextStyle(
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Text(
                                                        spData['results'][index]
                                                            ['service'],
                                                        style: TextStyle(
                                                          color: Colors.black38,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 35, right: 10),
                                                  child: Text(
                                                    "Rs. $pp hrs",
                                                    style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            141, 76, 175, 79),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
            ),
          )
        ],
      ),
    );
  }
}
