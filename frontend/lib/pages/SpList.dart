import 'package:flutter/material.dart';
import 'package:frontend/pages/sp_profile.dart';
import 'package:http/http.dart';
import 'dart:convert';

class SpList extends StatefulWidget {
  const SpList({super.key});

  @override
  State<SpList> createState() => _SpListState();

  static void fetchSp() {}
}

class _SpListState extends State<SpList> {

  fetchSp(String params) async {
    try {
      Response response = await get(
        Uri.parse("http://10.0.2.2:8000/api/service_provider/?service=cleaner"),
      );
      var spDetail = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        Navigator.pop(
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
                  body: Container(
                    margin: EdgeInsets.only(left: 25, right: 25, top: 20),
                    child: SingleChildScrollView(
                      child: Container(
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 7,
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
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                bottomLeft:
                                                    Radius.circular(20)),
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
                                                bottomRight:
                                                    Radius.circular(20)),
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
                                                          "Mark Tatum",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        SizedBox(height: 10),
                                                        Text(
                                                          "Cleaner",
                                                          style: TextStyle(
                                                            color:
                                                                Colors.black38,
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
                                                            color:
                                                                Colors.black26,
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
