import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/API/CallAPI.dart';
import 'package:http/http.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class reviewSection extends StatefulWidget {
  var uID;
  var id;
  reviewSection({super.key, this.id, this.uID});

  @override
  State<reviewSection> createState() => _reviewSectionState();
}

class _reviewSectionState extends State<reviewSection> {
  var _data;
  var length;
  var date;
  var timeAgo;
  CallApi obj = CallApi();

  TextEditingController comment = TextEditingController();

  getFeedback(int id) async {
    try {
      Response response = await get(
        Uri.parse("${obj.url}/feedback/review/?spID=$id"),
      );
      var feedback = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        setState(() {
          _data = feedback;
          length = _data.length;
        });
      }
      print(feedback);
    } catch (e) {
      return e;
    }
  }

  postFeedback(int id, int uID) async {
    try {
      Response res = await post(
        Uri.parse("${obj.url}/feedback/review/"),
        body: {
          'uID': uID,
          'pID': id,
          'comment': comment.text.toString(),
        },
      );

      if (res.statusCode == 200) {
        print("called");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => this.widget));
      }
    } catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getFeedback(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          color: const Color.fromARGB(203, 255, 255, 255),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true,
            clipBehavior: Clip.hardEdge,
            child: Scrollbar(
              radius: const Radius.circular(10),
              thickness: 10,
              // thumbVisibility: true,
              child: Container(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
                height: 310,
                child: ListView.builder(
                  itemCount: length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 115,
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: const <Widget>[
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/default-profile.png'),
                                radius: 15,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "user",
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
                          if (_data != null)
                            Text(
                              _data[index]['comment'],
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
                            child: const Text(
                              // _data!=null?DateTime.now().subtract(Duration()):,
                              // _data != null ? timeAgo :
                              '5 min ago',
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Divider(
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
              controller: comment,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      postFeedback(widget.id, widget.uID);
                    },
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
                        color: Color(0xffEEF1F9),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: new Color(0xffF5591F),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: Color.fromARGB(160, 238, 237, 237),
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }
}
