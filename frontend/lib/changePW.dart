import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend/API/CallAPI.dart';
import 'package:frontend/pages/manage_profile.dart';
import 'package:http/http.dart';

class ChangePW extends StatefulWidget {
  var id;
  ChangePW({super.key, this.id});

  @override
  State<ChangePW> createState() => _ChangePWState();
}

class _ChangePWState extends State<ChangePW> {
  TextEditingController _newpw = TextEditingController();
  TextEditingController _repw = TextEditingController();

  CallApi obj = CallApi();
  @override
  Widget build(BuildContext context) {
    _changePw() async {
      try {
        Response _pw =
            await put(Uri.parse(obj.url + "/api/change-password/"), body: {
          'id': widget.id.toString(),
          'password': _newpw.text.toString(),
          'repassword': _repw.text.toString(),
        });
        var msg = jsonDecode(_pw.body.toString());

        if (_pw.statusCode == 200) {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            headerAnimationLoop: false,
            animType: AnimType.bottomSlide,
            title: 'Success',
            desc: msg['message'],
            buttonsTextStyle: const TextStyle(color: Colors.black),
            showCloseIcon: true,
            btnOkOnPress: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ).show();
        }
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 68,
        title: Padding(
          padding: const EdgeInsets.only(left: 69, top: 4),
          child: Text(
            "Change Password",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xffF2861E),
        // elevation: 0,
      ),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 40),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  obscureText: true,
                  controller: _newpw,
                  decoration: InputDecoration(
                      hintText: "New Password",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: new Color(0xffF2861E),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 25, right: 25, top: 20),
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  obscureText: true,
                  controller: _repw,
                  decoration: InputDecoration(
                      hintText: "Re-type Password",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.shade200,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: new Color(0xffF2861E),
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.grey[200],
                      filled: true),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.only(left: 5, right: 5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xffF2861E),
                    minimumSize: Size(200, 50)),
                onPressed: () {
                  _changePw();
                },
                child: Text(
                  "Change",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
