import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

class reviewSection extends StatefulWidget {
  var id;
  reviewSection({super.key, this.id});

  @override
  State<reviewSection> createState() => _reviewSectionState();
}

class _reviewSectionState extends State<reviewSection> {
  var _data;
  var length;
  var date;
  var timeAgo;
  getFeedback(int id) async {
    Response _response = await get(
      Uri.parse("http://10.0.2.2:8000/feedback/review/?spID=$id"),
    );
    var feedback = jsonDecode(_response.body.toString());

    if (_response.statusCode == 200) {
      setState(() {
        _data = feedback;
        length = _data.length;
        date = DateFormat("HH:mm:ss").format(_data['created']);
        timeAgo = DateTime.now().subtract(Duration(days: date));
      });
    }
    print(feedback);
    // feedback['created'];
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
      // color: Colors.red,

      height: 400,
      decoration: BoxDecoration(
          color: Color.fromARGB(203, 255, 255, 255),
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
                  itemCount: length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 115,
                      // color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            child: Text(
                              // _data!=null?DateTime.now().subtract(Duration()):,
                              _data != null ? timeAgo : '20 min ago',
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
