import 'package:flutter/material.dart';
import 'package:frontend/API/CallAPI.dart';
import 'package:frontend/pages/sp_profile.dart';
import 'package:http/http.dart';
import 'dart:convert';

class SpList extends StatefulWidget {
  var service;
  var uID;
  var mapData;
  SpList({super.key, this.service, this.uID, this.mapData});

  @override
  State<SpList> createState() => _SpListState();
}

class _SpListState extends State<SpList> {
  var mapData;
  var length;
  var filterData;
  bool filtered = false;

  CallApi obj = CallApi();
  filter(String option, String service) async {
    try {
      Response filter_res = await get(
        Uri.parse(obj.url + "/api/filter/?filter=$option&service=$service"),
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
        Uri.parse(obj.url + "/api/service_provider/?service=$params"),
      );
      var spDetail = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        setState(() {
          mapData = spDetail;
        });
        print(mapData);

        // ignore: use_build_context_synchronously
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    backgroundColor: const Color(0xffFBFBFB),
                    foregroundColor: const Color(0xffF2861E),
                    elevation: 0,
                  ),
                  body: mapData.length == 0
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
                          margin: const EdgeInsets.only(
                              left: 25, right: 25, top: 20),
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(left: 5, bottom: 20),
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
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            primary: Colors.orange,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    255, 172, 64, 0.204),
                                            side: const BorderSide(
                                                width: 0.5,
                                                color: Colors.orangeAccent),
                                            minimumSize: const Size(80, 30)),
                                        onPressed: () {
                                          filter("asce", params);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          this.widget));
                                        },
                                        child: const Text(
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
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            primary: Colors.orange,
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    255, 172, 64, 0.204),
                                            side: const BorderSide(
                                                width: 0.5,
                                                color: Colors.orangeAccent),
                                            minimumSize: const Size(90, 30)),
                                        onPressed: () {
                                          filter("desc", params);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          this.widget));
                                        },
                                        child: const Text(
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
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: mapData.length,
                                    itemBuilder: (context, index) {
                                      if (mapData[index]['active_status'] ==
                                          true) {
                                        return Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 10),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SP_profile(
                                                            price:
                                                                mapData[index]
                                                                    ['price'],
                                                            uID: widget.uID,
                                                            id: mapData[index]
                                                                ['id'],
                                                            spName: mapData[
                                                                        index][
                                                                    'service_provider']
                                                                ['name'],
                                                            email: mapData[
                                                                        index][
                                                                    'service_provider']
                                                                ['email'],
                                                            contact: mapData[
                                                                        index][
                                                                    'service_provider']
                                                                ['phone'],
                                                            location: mapData[
                                                                        index][
                                                                    'service_provider']
                                                                ['location'],
                                                            service:
                                                                mapData[index]
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
                                                  decoration: const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(20),
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
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(20),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20)),
                                                      color: Colors.white,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
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
                                                                    filtered ==
                                                                            false
                                                                        ? mapData[index]['service_provider']
                                                                            [
                                                                            'name']
                                                                        : filterData[index]['service_provider']
                                                                            [
                                                                            'name'],
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),
                                                                  Text(
                                                                    mapData[index]
                                                                        [
                                                                        'service'],
                                                                    style:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .black38,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                          Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 35,
                                                                      right:
                                                                          10),
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
                                                                      fontSize:
                                                                          12,
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

  @override
  void initState() {
    // TODO: implement initState
    fetchSp(widget.service.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.service;
    return Container();
  }
}
