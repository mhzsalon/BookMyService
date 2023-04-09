// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:frontend/API/CallAPI.dart';
import 'package:frontend/pages/home_page_components/Category.dart';
import 'package:frontend/pages/home_page_components/Offers.dart';
import 'package:frontend/pages/home_page_components/trending.dart';
import 'package:frontend/pages/notification.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:frontend/pages/sp_profile.dart';

class HomePage extends StatefulWidget {
  var uID;
  var userType;
  var name;
  HomePage({super.key, this.userType, this.name, this.uID});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var mapData = [];
  var length;
  CallApi obj = CallApi();

  fetchSp(String params) async {
    try {
      Response response = await get(
        Uri.parse(obj.url + "api/service_provider/?service=$params"),
      );
      var spDetail = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        _HomePageState().setState(() {
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
    String type = widget.userType;

    return Scaffold(
      backgroundColor: Color(0xffEEF1F9),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              top(),
              type == "Clients" ? search() : Text("Welcome Service Provider"),
              type == "Clients" ? OfferSlider() : Container(),
              type == "Clients"
                  ? Categories(
                      uID: widget.uID,
                    )
                  : Container(),
              type == "Clients" ? TrendingSP() : Container(),
            ],
          ),
        ),
      )),
    );
  }

  Widget top() {
    String user_name = widget.name;

    return Container(
      margin: const EdgeInsets.only(top: 30, left: 25, right: 25),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: <Widget>[
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.orangeAccent,
                  child: CircleAvatar(
                    radius: 19,
                    backgroundImage: AssetImage("images/default-profile.png"),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(
                    user_name,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NotificationPage()));
              },
              child: Container(
                margin: EdgeInsets.only(left: 45),
                width: 45,
                height: 45,
                child: Icon(Icons.notifications, color: Colors.white, size: 24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.orangeAccent,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget search() {
    return GestureDetector(
      onTap: () {
        showSearch(
          context: context,
          delegate: CustomSearchDelegate(),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 25, left: 25, right: 25),
        height: 55,
        decoration: BoxDecoration(
            color: Color.fromARGB(203, 255, 255, 255),
            borderRadius: BorderRadius.circular(15)),
        child: Row(children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.search,
            size: 22,
            color: Colors.black45,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "Search here",
            style: TextStyle(
              color: Colors.black45,
              fontSize: 18,
            ),
          ),
        ]),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Cleaner',
    'Painter',
    'Carpenter',
    'Babysitter',
    'Electrician',
    'Elderly care',
    'Plumber',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var sp_types in searchTerms) {
      if (sp_types.toLowerCase().contains((query.toLowerCase()))) {
        matchQuery.add(sp_types);
      }
    }
    var result = matchQuery[0];
    print(result);
    _HomePageState().fetchSp(result);
    print(_HomePageState().fetchSp(result));
    var length = _HomePageState().length;
    var mapData = _HomePageState().mapData;
    return Scaffold(
        body: mapData == null
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

    // return ListView.builder(
    //   itemCount: matchQuery.length,
    //   itemBuilder: ((context, index) {
    //     var result = matchQuery[index];
    //     fetchSp(result);

    //   }),
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _resultScreen(String result) {}

    List<String> matchQuery = [];
    for (var sp_types in searchTerms) {
      if (sp_types.toLowerCase().contains((query.toLowerCase()))) {
        matchQuery.add(sp_types);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: ((context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      }),
    );
  }
}
