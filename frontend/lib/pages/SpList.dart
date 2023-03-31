import 'package:flutter/material.dart';
import 'package:frontend/pages/sp_profile.dart';
import 'package:http/http.dart';
import 'dart:convert';

class SpList extends StatefulWidget {
  var service;
  SpList({super.key, this.service});

  @override
  State<SpList> createState() => _SpListState();
}

class _SpListState extends State<SpList> {
  var mapData;
  var length;
  
  @override
  void initState() {
    // TODO: implement initState
    fetchSp(widget.service);
    super.initState();
  }

  fetchSp(String params) async {
    try {
      Response response = await get(
        Uri.parse("http://10.0.2.2:8000/api/service_provider/?service=$params"),
      );
      var spDetail = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        setState(() {
          mapData = spDetail;
          length = mapData.length;
        });

        print(mapData);
      } else {
        print(
          spDetail["message"],
        );
      }
    } catch (e) {
      print("Error is $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.service;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 68,
          title: Padding(
            padding: const EdgeInsets.only(left: 69, top: 4),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Color(0xffFBFBFB),
          foregroundColor: Color(0xffF2861E),
          elevation: 0,
        ),
        body: length == 0
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
                        itemCount: length,
                        itemBuilder: (context, index) {
                          if (mapData[index]['active_status'] == true) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SP_profile(
                                                id: mapData[index]['id'],
                                                spName: mapData[index]
                                                        ['service_provider']
                                                    ['name'],
                                                email: mapData[index]
                                                        ['service_provider']
                                                    ['email'],
                                                contact: mapData[index]
                                                        ['service_provider']
                                                    ['phone'],
                                                location: mapData[index]
                                                        ['service_provider']
                                                    ['location'],
                                                service: mapData[index]
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
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              bottomLeft: Radius.circular(20)),
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
                                                        mapData[index][
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
                                                        mapData[index]
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
                                                  margin: EdgeInsets.only(
                                                      top: 35, right: 10),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: const [
                                                      Icon(
                                                        Icons.star,
                                                        size: 18,
                                                        color: Colors.yellow,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        "4.5",
                                                        style: TextStyle(
                                                          color: Colors.black26,
                                                          fontWeight:
                                                              FontWeight.bold,
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
                          } else {
                            return Container();
                          }
                        }),
                  ),
                ),
              ));
  }
}
