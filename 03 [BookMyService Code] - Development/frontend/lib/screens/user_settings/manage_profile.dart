// ignore_for_file: non_constant_identifier_names, must_be_immutable, unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:frontend/Services/CallAPI.dart';
import 'package:frontend/screens/user_settings/changePW.dart';
import 'package:frontend/editUser.dart';
import 'package:dio/dio.dart';
import 'package:frontend/screens/auth/login/login.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
// import 'package:http_parser/http_parser.dart' as http_parser;
import 'dart:convert';

// import 'package:dio/dio.dart';

class Profile extends StatefulWidget {
  var id;
  var email;
  var name;
  var type;
  var avatar;
  Profile({super.key, this.email, this.name, this.type, this.id, this.avatar});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool active = true;

  CallApi obj = CallApi();

  Future<void> _getUserPicture(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(
      source: imageSource,
    );
    if (image == null) {
      return;
    }
    _imageName = path.basename(image.path);

    setState(() {
      _selectedImage = File(image.path);
    });
  }

  File? _selectedImage;
  String? _imageName;

  status(String id) async {
    final response = await http.get(
      Uri.parse(obj.url + "/api/activate/?id=$id"),
    );
    if (response.statusCode == 200) {
      var spDetail = jsonDecode(response.body.toString());

      setState(() {
        active = spDetail['active_status'];
      });
      print(spDetail);
    }
  }

  activateUser(String id) async {
    final response = await http.put(
      Uri.parse("${obj.url}/api/activate/?id=$id"),
    );
    var spDetail = jsonDecode(response.body.toString());
    print(spDetail['message']);
  }

  deactivateUser(String id) async {
    final response = await http.put(
      Uri.parse("${obj.url}/api/deactivate/?id=$id"),
    );
    var spDetail = jsonDecode(response.body.toString());
    print(spDetail['message']);
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.type == 'Service Provider') {
      status(widget.id.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String _name = widget.name;
    String _email = widget.email;
    String imageURL = widget.avatar.toString();
    setAvatar(int id) async {
      print("called");
      Dio dio = Dio();

      final formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(
          _selectedImage!.path,
          filename: _imageName,
        ),
        'uID': id
      });

      print("done");

      final response = await dio.put("${obj.url}/api/avatar/", data: formData);
      print("don2e");

      if (response.statusCode == 200) {
        setState(() {
          var userIMG = response.data;
          print(userIMG);
          print(userIMG['avatar']);
          setState(() {
            imageURL = userIMG['avatar'];
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => this.widget));
            print(imageURL);
          });
        });
      }
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 80),
                    child: imageURL != null
                        ? CircleAvatar(
                            radius: 70.0,
                            backgroundImage:
                                NetworkImage("${obj.url}$imageURL"),
                          )
                        : const CircleAvatar(
                            radius: 70.0,
                            backgroundImage:
                                AssetImage("images/default-profile.png"),
                          ),
                  ),
                  Positioned(
                    // left: 0,
                    // right: 0,
                    top: 182,
                    child: GestureDetector(
                      onTap: () async {
                        await _getUserPicture(
                          ImageSource.gallery,
                        ).then((value) {
                          setAvatar(widget.id);
                        });
                      },
                      child: Container(
                          height: 35,
                          margin: EdgeInsets.only(left: 80),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: new Color(0xffF5591F),
                            gradient: LinearGradient(
                                colors: [
                                  (new Color(0xffF5591F)),
                                  (new Color(0xffF2861E))
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.white,
                            size: 20,
                          )
                          // child: ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //         elevation: 5,
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(100)),
                          //         foregroundColor: Colors.white,
                          //         backgroundColor: Color(0xffF2861E),
                          //         minimumSize: Size(30, 30)),
                          //     onPressed: () {
                          //       getImage();
                          //       // setAvatar(widget.id);
                          //     },
                          //     child: Icon(
                          //       Icons.camera_alt_rounded,
                          //       color: Colors.white,
                          //       size: 20,
                          //     )),
                          ),
                    ),
                  )
                ]),

            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Text(
                _name,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 3),
              child: Text(
                _email,
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 100, right: 100),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xffF2861E),
                    minimumSize: Size(100, 50)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditUser(
                                id: widget.id,
                                type: widget.type,
                              )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.edit,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),

            // Change Password
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePW(id: widget.id)));
              },
              child: Container(
                margin: EdgeInsets.only(top: 55, left: 35, right: 35),
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(160, 238, 237, 237),
                ),
                child: Row(children: const <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.key,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Change Password",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
              ),
            ),

            widget.type == "Service Provider"
                ?
                //Active
                Container(
                    margin: EdgeInsets.only(top: 15, left: 35, right: 35),
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(160, 238, 237, 237),
                    ),
                    child: Row(children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        Icons.account_circle_sharp,
                        color: Colors.black54,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Active",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 130,
                      ),
                      Switch(
                        value: active,
                        activeColor: Colors.green,
                        onChanged: (bool value) {
                          setState(() {
                            active = value;
                            active == true
                                ? activateUser(widget.id.toString())
                                : deactivateUser(widget.id.toString());
                          });
                        },
                      ),
                    ]),
                  )
                : Container(),

            // logout
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 15, left: 35, right: 35),
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(160, 238, 237, 237),
                ),
                child: Row(children: const <Widget>[
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.logout,
                    color: Colors.black54,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
