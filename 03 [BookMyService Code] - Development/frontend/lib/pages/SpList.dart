// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:frontend/Services/CallAPI.dart';
import 'package:frontend/screens/service%20profile/sp_profile.dart';
import 'package:http/http.dart';
import 'dart:convert';

class SpList extends StatefulWidget {
  SpList(
      {super.key,
      this.service,
      this.uID,
      this.mapData,
      this.name,
      this.userType,
      this.length});
  var service;
  var uID;
  var mapData;
  var userType;
  var name;
  var length;

  @override
  State<SpList> createState() => _SpListState();
}

class _SpListState extends State<SpList> {
  var mapData;
  var filterData;
  bool filtered = false;

  CallApi obj = CallApi();

  @override
  void initState() {
    // TODO: implement initState
    // fetchSp(widget.service.toString());
    print(widget.mapData);
    print(widget.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.service;
    filter(String option, String service) async {
      try {
        Response filter_res = await get(
          Uri.parse(obj.url + "/api/filter/?filter=$option&service=$service"),
        );
        if (filter_res.statusCode == 200) {
          setState(() {
            var data = jsonDecode(filter_res.body.toString());
            widget.mapData = data;
            print(filterData);
          });
        }
      } catch (e) {
        return e;
      }
    }

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 68,
          title: Padding(
            padding: const EdgeInsets.only(left: 69, top: 4),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: const Color(0xffFBFBFB),
          foregroundColor: const Color(0xffF2861E),
          elevation: 0,
        ),
        body: widget.length == 0
            ? const Center(
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
                margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          const Text(
                            "Sort by:",
                            style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 3, right: 3),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  primary: Colors.orange,
                                  backgroundColor:
                                      const Color.fromRGBO(255, 172, 64, 0.204),
                                  side: const BorderSide(
                                      width: 0.5, color: Colors.orangeAccent),
                                  minimumSize: const Size(70, 30)),
                              onPressed: () {
                                filter("asce", title);
                                setState(() {
                                  filtered = true;
                                });
                              },
                              child: const Text(
                                "Low price",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 4, right: 4),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  primary: Colors.orange,
                                  backgroundColor:
                                      const Color.fromRGBO(255, 172, 64, 0.204),
                                  side: const BorderSide(
                                      width: 0.5, color: Colors.orangeAccent),
                                  minimumSize: const Size(90, 30)),
                              onPressed: () {
                                filter("desc", title);
                                setState(() {
                                  filtered = true;
                                });
                              },
                              child: const Text(
                                "High price",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 4, right: 4),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                  primary: Colors.orange,
                                  backgroundColor:
                                      const Color.fromRGBO(255, 172, 64, 0.204),
                                  side: const BorderSide(
                                      width: 0.5, color: Colors.orangeAccent),
                                  minimumSize: const Size(90, 30)),
                              onPressed: () {
                                filter("most", title);
                                setState(() {
                                  filtered = true;
                                });
                              },
                              child: const Text(
                                "Most booked",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      reverse: true,
                      child: Container(
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.length,
                            itemBuilder: (context, index) {
                              if (widget.mapData[index]['active_status'] ==
                                  true) {
                                var pp = widget.mapData[index]['price'];
                                String imageURL = widget.mapData[index]
                                        ['service_provider']['avatar']
                                    .toString();
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SP_profile(
                                                    mapData: widget.mapData,
                                                    length: widget.length,
                                                    trend: false,
                                                    name: widget.name,
                                                    image: imageURL,
                                                    usertype: widget.userType,
                                                    description: widget.mapData[
                                                                    index][
                                                                'description'] ==
                                                            ""
                                                        ? null
                                                        : widget.mapData[index]
                                                            ['description'],
                                                    price: widget.mapData[index]
                                                        ['price'],
                                                    uID: widget.uID,
                                                    id: widget.mapData[index]
                                                        ['id'],
                                                    spName: widget
                                                                .mapData[index]
                                                            ['service_provider']
                                                        ['name'],
                                                    email: widget.mapData[index]
                                                            ['service_provider']
                                                        ['email'],
                                                    contact: widget
                                                                .mapData[index]
                                                            ['service_provider']
                                                        ['phone'],
                                                    location: widget
                                                                .mapData[index]
                                                            ['service_provider']
                                                        ['location'],
                                                    service:
                                                        widget.mapData[index]
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
                                                const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20)),
                                            color: Colors.white38,
                                            image: imageURL == null
                                                ? const DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        "default-profile.png"),
                                                  )
                                                : DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "${obj.url}$imageURL"),
                                                  ),
                                          ),
                                        ),
                                        // Text section
                                        Expanded(
                                          child: Container(
                                            height: 90,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight:
                                                      Radius.circular(20)),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
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
                                                          if (widget.mapData !=
                                                              null)
                                                            Text(
                                                              widget.mapData[
                                                                          index]
                                                                      [
                                                                      'service_provider']
                                                                  ['name'],
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          const SizedBox(
                                                              height: 10),
                                                          if (widget.mapData !=
                                                              null)
                                                            Text(
                                                              widget.mapData[
                                                                      index]
                                                                  ['service'],
                                                              style:
                                                                  const TextStyle(
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
                                                          const EdgeInsets.only(
                                                              top: 35,
                                                              right: 10),
                                                      child: Text(
                                                        "Rs. $pp hrs",
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
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
  }
}
