// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontend/pages/SpList.dart';
import 'package:frontend/pages/registration_forms/service_provider.dart';
import 'package:frontend/pages/sp_profile.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final PageController controller = PageController();
  var mapData;

  fetchSp(String params) async {
    try {
      Response response = await get(
        Uri.parse("http://10.0.2.2:8000/api/service_provider/?service=$params"),
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
                          child: SingleChildScrollView(
                            child: Container(
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: mapData.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SP_profile()));
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
                                                          topLeft:
                                                              Radius.circular(
                                                                  20),
                                                          bottomLeft:
                                                              Radius.circular(
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
                                                          topRight:
                                                              Radius.circular(
                                                                  20),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  20)),
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
                                                                mapData[index][
                                                                        'service_provider']
                                                                    ['name'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black54,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                mapData[index]
                                                                    ['service'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black38,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ]),
                                                      ),
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 35,
                                                                  right: 10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons.star,
                                                                size: 18,
                                                                color: Colors
                                                                    .yellow,
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                "4.5",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black26,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
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

  List<String> _service = [
    'Cleaner',
    'Carpenter',
    'Babysitter',
    'Painter',
    'Electrician',
    'Elderly care',
    'Plumber',
  ];

  var _serviceIcons = [
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

          Scrollbar(
            radius: Radius.circular(10),
            thickness: 5,
            child: Container(
              width: 350,
              margin: EdgeInsets.only(bottom: 15),
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _service.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      fetchSp(_service[index]);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 27, top: 15, bottom: 5),
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
