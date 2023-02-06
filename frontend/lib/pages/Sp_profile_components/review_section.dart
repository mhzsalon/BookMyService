import 'dart:math';

import 'package:flutter/material.dart';

class reviewSection extends StatefulWidget {
  const reviewSection({super.key});

  @override
  State<reviewSection> createState() => _reviewSectionState();
}

class _reviewSectionState extends State<reviewSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,

      height: 400,
      decoration: BoxDecoration(
          color: new Color(0xffF4F0F0),
          // gradient: LinearGradient(
          //     colors: [(new Color(0xffF5591F)), (new Color(0xffF2861E))],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(top: 8),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true,
            clipBehavior: Clip.hardEdge,
            child: Scrollbar(
              radius: Radius.circular(10),
              thickness: 10,
              // thumbVisibility: true,
              child: Container(
                padding: EdgeInsets.only(left: 25, right: 25, top: 30),
                height: 310,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 115,
                      // color: Colors.red,
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/default-profile.png'),
                                radius: 15,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "user12",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    letterSpacing: 0.5),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type. ",
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                letterSpacing: 0.5),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: 400,
                            child: Text(
                              "10 mins ago",
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Divider(
                            color: Color.fromARGB(30, 0, 0, 0),
                            thickness: 2,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            height: 55,
            margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            alignment: Alignment.center,
            child: TextField(
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      color: Color(0xffF2861E),
                    ),
                  ),
                  hintText: "Write your review",
                  hintStyle: TextStyle(
                    color: Colors.black45,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: new Color(0xffF5591F),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Colors.white,
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }
}
