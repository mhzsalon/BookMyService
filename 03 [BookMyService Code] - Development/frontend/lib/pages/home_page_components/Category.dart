// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/API/CallAPI.dart';
import 'package:frontend/pages/SpList.dart';
import 'package:frontend/pages/registration_forms/service_provider.dart';
import 'package:frontend/pages/sp_profile.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Categories extends StatefulWidget {
  var uID;
  var usertype;
  var name;
  Categories({super.key, this.uID, this.name, this.usertype});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final PageController controller = PageController();
  var mapData;
  var filterData;
  bool filtered = false;

  CallApi obj = CallApi();

  filter(String option, String service) async {
    try {
      Response filter_res = await get(
        Uri.parse("${obj.url}/api/filter/?filter=$option&service=$service"),
      );
      if (filter_res.statusCode == 200) {
        setState(() {
          var data = jsonDecode(filter_res.body.toString());
          filterData = data;
          print(filterData);
        });
      }
    } catch (e) {
      return e;
    }
  }

  fetchSp(String params) async {
    try {
      Response response = await get(
        Uri.parse("${obj.url}/api/service_provider/?service=$params"),
      );
      var spDetail = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        setState(() {
          mapData = spDetail;
        });
        print(mapData);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: 68,
                    title: Padding(
                      padding: const EdgeInsets.only(left: 69, top: 4),
                      child: Text(
                        params,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    backgroundColor: Color(0xffFBFBFB),
                    foregroundColor: Color(0xffF2861E),
                    elevation: 0,
                  ),
                  body: mapData.length == 0
                      ? Center(
                          child: Text(
                            "No service available",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 5, bottom: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      "Sort by:",
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            primary: Colors.orange,
                                            backgroundColor: Color.fromRGBO(
                                                255, 172, 64, 0.204),
                                            side: BorderSide(
                                                width: 0.5,
                                                color: Colors.orangeAccent),
                                            minimumSize: Size(80, 30)),
                                        onPressed: () {
                                          filter("asce", params);
                                          setState(() {
                                            filtered = true;
                                          });
                                          // Navigator.pushReplacement(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder:
                                          //             (BuildContext context) =>
                                          //                 this.widget));
                                        },
                                        child: Text(
                                          "low price",
                                          style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                      // child: OutlinedButton(
                                      //   style: ,
                                      // ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            primary: Colors.orange,
                                            backgroundColor: Color.fromRGBO(
                                                255, 172, 64, 0.204),
                                            side: BorderSide(
                                                width: 0.5,
                                                color: Colors.orangeAccent),
                                            minimumSize: Size(90, 30)),
                                        onPressed: () {
                                          filter("desc", params);
                                          setState(() {
                                            filtered = true;
                                          });
                                        },
                                        child: Text(
                                          "high price",
                                          style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                      // child: OutlinedButton(
                                      //   style: ,
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                reverse: true,
                                child: Container(
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: mapData.length,
                                      itemBuilder: (context, index) {
                                        if (mapData[index]['active_status'] ==
                                            true) {
                                          var pp = mapData[index]['price'];
                                          return Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SP_profile(
                                                              name: widget.name,
                                                              usertype: widget
                                                                  .usertype,
                                                              description: mapData[
                                                                      index][
                                                                  'description'],
                                                              price:
                                                                  mapData[index]
                                                                      ['price'],
                                                              uID: widget.uID,
                                                              id: mapData[index]
                                                                  ['id'],
                                                              spName: mapData[
                                                                          index]
                                                                      [
                                                                      'service_provider']
                                                                  ['name'],
                                                              email: mapData[
                                                                          index]
                                                                      [
                                                                      'service_provider']
                                                                  ['email'],
                                                              contact: mapData[
                                                                          index]
                                                                      [
                                                                      'service_provider']
                                                                  ['phone'],
                                                              location: mapData[
                                                                          index]
                                                                      [
                                                                      'service_provider']
                                                                  ['location'],
                                                              service: mapData[
                                                                      index]
                                                                  ['service'],
                                                            )));
                                                // builder: (context) => CandidateProfile()));
                                              },
                                              child: Row(
                                                children: [
                                                  // Image section
                                                  Container(
                                                    width: 90,
                                                    height: 90,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20)),
                                                        color: Colors.white38,
                                                        image: DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: AssetImage(
                                                                "images/default-profile.png"))),
                                                  ),
                                                  // Text section
                                                  Expanded(
                                                    child: Container(
                                                      height: 90,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        20)),
                                                        color: Colors.white,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
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
                                                                      mapData[index]
                                                                              [
                                                                              'service_provider']
                                                                          [
                                                                          'name'],
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black54,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      mapData[index]
                                                                          [
                                                                          'service'],
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black38,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        fontSize:
                                                                            12,
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ),
                                                            Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: 35,
                                                                        right:
                                                                            10),
                                                                child: Text(
                                                                  "Rs. $pp hrs",
                                                                  style: TextStyle(
                                                                      color: Color.fromARGB(
                                                                          141,
                                                                          76,
                                                                          175,
                                                                          79),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
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
                                        } else {
                                          return Container();
                                        }
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ));
            },
          ),
        );
      } else {
        print(
          spDetail["message"],
        );
      }
    } catch (e) {
      print("Error is $e");
    }
  }

  final List<String> _service = [
    'Cleaner',
    'Carpenter',
    'Babysitter',
    'Painter',
    'Electrician',
    'Elderly care',
    'Plumber',
  ];

  final _serviceIcons = [
    Icons.cleaning_services_rounded,
    Icons.carpenter_rounded,
    Icons.baby_changing_station_rounded,
    Icons.format_paint_rounded,
    Icons.electrical_services_rounded,
    Icons.elderly_rounded,
    Icons.plumbing,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(left: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "Categories",
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),

          Row(
            children: [
              Scrollbar(
                radius: Radius.circular(10),
                thickness: 5,
                child: Container(
                  width: 330,
                  margin: EdgeInsets.only(bottom: 15),
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _service.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          fetchSp(_service[index]);
                          // print(mapData);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SpList(
                          //               service: _service[index].toString(),
                          //               uID: widget.uID.toString(),
                          //               mapData: mapData,
                          //             )));
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(right: 22, top: 15, bottom: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                child: Icon(_serviceIcons[index],
                                    color: Colors.orangeAccent, size: 28),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(255, 172, 64, 0.204),
                                ),
                              ),
                              Text(
                                _service[index],
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  size: 40,
                  color: Colors.black26,
                ),
              )
            ],
          ),
          // Container(
          //   color: Colors.blue,
          //   // width: 360,
          //   height: 100,
          //   child:
          // ),
        ],
      ),
    );
  }
}
