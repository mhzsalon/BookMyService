// ignore_for_file: must_be_immutable, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../../Services/CallAPI.dart';

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

  getFeedback(String id) async {
    try {
      Response response = await get(
        Uri.parse("${obj.url}/feedback/review/?spID=$id"),
      );
      var feedback = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        setState(() {
          _data = feedback;
          length = _data['review'].length;
        });
      }
      print(feedback);
    } catch (e) {
      return e;
    }
  }

  postFeedback(String id, String uID) async {
    try {
      Response res = await post(
        Uri.parse("${obj.url}/feedback/review/"),
        body: {
          'uID': uID,
          'pID': id,
          'comment': comment.text.toString(),
        },
      );
      var feedback = jsonDecode(res.body.toString());
      setState(() {
        comment.text = "";
      });
    } catch (e) {
      return e;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // postFeedback(widget.id, widget.uID);
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
              child: _data == null
                  ? Container(
                      height: 310,
                      child: const Center(
                        child: Text("Loading..."),
                      ),
                    )
                  : Container(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 30),
                      height: 310,
                      child: length == 0
                          ? const Center(
                              child: Text("No reviews."),
                            )
                          : ListView.builder(
                              itemCount: length,
                              itemBuilder: (context, index) {
                                String imageURL =
                                    _data['review'][index]['user_id']['avatar'];
                                return SizedBox(
                                  height: 115,
                                  // color: Colors.red,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                "${obj.url}$imageURL"),
                                            radius: 15,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          if (_data != null)
                                            Text(
                                              _data['review'][index]['user_id']
                                                  ['name'],
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      if (_data != null)
                                        Text(
                                          _data['review'][index]['comment'],
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12,
                                              letterSpacing: 0.5),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      if (_data != null)
                                        Container(
                                          width: 400,
                                          child: Text(
                                            // _data!=null?DateTime.now().subtract(Duration()):,
                                            // _data != null ? timeAgo :
                                            _data['time'][index].toString(),
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
            margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
            alignment: Alignment.center,
            child: TextField(
              controller: comment,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      postFeedback(widget.id, widget.uID);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Color(0xffF2861E),
                    ),
                  ),
                  hintText: "Write your review",
                  hintStyle: const TextStyle(
                    color: Colors.black45,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffEEF1F9),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: new Color(0xffF5591F),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  fillColor: const Color.fromARGB(160, 238, 237, 237),
                  filled: true),
            ),
          ),
        ],
      ),
    );
  }
}
