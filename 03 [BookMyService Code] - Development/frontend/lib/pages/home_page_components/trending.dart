import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/API/CallAPI.dart';
import 'package:frontend/pages/sp_profile.dart';
import 'package:http/http.dart';

class TrendingSP extends StatefulWidget {
  const TrendingSP({super.key});

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
      length = spData.length;
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
              child: Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SP_profile()));
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
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Mark",
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "Cleaner",
                                                  style: TextStyle(
                                                    color: Colors.black38,
                                                    fontWeight: FontWeight.bold,
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
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
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
                                                    fontWeight: FontWeight.bold,
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
          )
        ],
      ),
    );
  }
}
