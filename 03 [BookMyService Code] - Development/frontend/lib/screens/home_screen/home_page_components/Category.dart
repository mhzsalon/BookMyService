// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:frontend/Services/CallAPI.dart';
import 'package:frontend/pages/SpList.dart';
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
  var length;
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
          length = mapData.length;
        });

        if (mapData != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SpList(
                      mapData: mapData,
                      service: params,
                      uID: widget.uID,
                      name: widget.name,
                      userType: widget.usertype,
                      length: length,
                    )),
          );
        }
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
