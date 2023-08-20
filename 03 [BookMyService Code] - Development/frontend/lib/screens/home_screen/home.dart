// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/Services/CallAPI.dart';
import 'package:frontend/screens/home_screen/home_page_components/Category.dart';
import 'package:frontend/screens/home_screen/home_page_components/Offers.dart';
import 'package:frontend/screens/home_screen/home_page_components/trending.dart';
import 'package:frontend/pages/notification.dart';
import 'package:frontend/provider/SpProvider.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:frontend/screens/service%20profile/sp_profile.dart';

class HomePage extends ConsumerStatefulWidget {
  var uID;
  var userType;
  var name;
  var avatar;
  HomePage({super.key, this.userType, this.name, this.uID, this.avatar});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  var mapData = [];
  var length;
  CallApi obj = CallApi();

  void getService() async {
    CallApi obj = CallApi();

    final response = await get(
      Uri.parse("${obj.url}/api/login/"),
    );

    if (response.statusCode == 200) {
      var resData = jsonDecode(response.body);

      for (var data in resData) {
        print(data);
        ref.read(spProvider.notifier).addSP(
            data['service_provider']['id'],
            data['id'],
            data['active_status'],
            data['description'],
            data['service'],
            data['price']);
        print("_______________");
      }
    }
  }

  fetchSp(String params) async {
    try {
      Response response = await get(
        Uri.parse("${obj.url}api/service_provider/?service=$params"),
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
  void initState() {
    // TODO: implement initState
    getService();
    super.initState();
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
              type == "Clients" ? search() : Container(),
              type == "Clients" ? OfferSlider() : spConatiner(),
              type == "Clients"
                  ? Categories(
                      uID: widget.uID,
                      usertype: widget.userType,
                      name: widget.name,
                    )
                  : Container(),
              type == "Clients"
                  ? TrendingSP(
                      uID: widget.uID,
                      usertype: widget.userType,
                      name: widget.name,
                    )
                  : Container(),
            ],
          ),
        ),
      )),
    );
  }

  Widget top() {
    String userName = widget.name;
    String imageURL = widget.avatar.toString();

    return Container(
      margin: const EdgeInsets.only(top: 30, left: 25, right: 25),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 22,
                  backgroundColor: Colors.orangeAccent,
                  child: CircleAvatar(
                    radius: 19,
                    backgroundImage: NetworkImage("${obj.url}$imageURL"),
                  ),
                ),
                // : CircleAvatar(
                //     radius: 22,
                //     backgroundColor: Colors.orangeAccent,
                //     child: CircleAvatar(
                //       radius: 19,
                //       backgroundImage:
                //           AssetImage("images/default-profile.png"),
                //     ),
                //   ),
                const SizedBox(
                  width: 8,
                ),
                Container(
                  margin: EdgeInsets.only(top: 6),
                  child: Text(
                    userName,
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

  Widget spConatiner() {
    return Container(
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
            color: Colors.white38,
          ),
          child: Row(
            children: [Text("Total bookings"), Text("14")],
          ),
        ),
      ]),
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
    for (var spTypes in searchTerms) {
      if (spTypes.toLowerCase().contains((query.toLowerCase()))) {
        matchQuery.add(spTypes);
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
    for (var spTypes in searchTerms) {
      if (spTypes.toLowerCase().contains((query.toLowerCase()))) {
        matchQuery.add(spTypes);
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
