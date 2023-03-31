import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart';

class EditUser extends StatefulWidget {
  var id;
  var type;
  EditUser({super.key, this.id, this.type});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phone = TextEditingController();
  String? serviceValue;

  var serviceList = [
    'Cleaner',
    'Carpenter',
    'Babysitter',
    'Painter',
    'Electrician',
    'Elderly care',
    'Plumber',
  ];

  _getSpDetail() {
    print("pssss");
  }

  _getUserDetail(String id) async {
    try {
      Response _pw = await get(
        Uri.parse("http://10.0.2.2:8000/api/update-user/?id=$id"),
      );
      var data = jsonDecode(_pw.body.toString());
      print(data);

      if (_pw.statusCode == 200) {
        setState(() {
          phone.text = data['phone'];
          name.text = data['name'];
          email.text = data['email'];
          location.text = data['location'];
          serviceValue = data['service'];
        });
      }
    } catch (e) {
      print(e);
    }
  }

  updateUser(String id) async {
    try {
      Response updated = await put(
          Uri.parse("http://10.0.2.2:8000/api/update-user/?id=$id"),
          body: {
            'name': name.text.toString(),
            'email': email.text.toString(),
            'location': location.text.toString(),
            'phone': phone.text.toString(),
          });
      var msg = jsonDecode(updated.body.toString());
      if (updated.statusCode == 200) {
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

  @override
  void initState() {
    // TODO: implement initState
    widget.type == "Service Provider"
        ? _getSpDetail()
        : _getUserDetail(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: Padding(
          padding: const EdgeInsets.only(left: 69, top: 4),
          child: Text(
            "Edit Profile",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        backgroundColor: Color(0xffF2861E),
        // elevation: 0,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 40),
                // alignment: Align?ment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          "Name",
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        )),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 54,
                      child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                            hintText: "Name",
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
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          "Email",
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        )),
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      height: 54,
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                            hintText: "Email",
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
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          "Location",
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        )),
                    Container(
                      height: 54,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: location,
                        decoration: InputDecoration(
                            hintText: "Location",
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
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 15, bottom: 10),
                        child: Text(
                          "Phone number",
                          style: TextStyle(fontSize: 16, color: Colors.black45),
                        )),
                    Container(
                      height: 54,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: phone,
                        decoration: InputDecoration(
                            hintText: "Phone number",
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
                  ],
                ),
              ),
              if (widget.type == "Service Provider")
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 5, bottom: 10),
                            child: Text(
                              "Service type",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black45),
                            )),
                        Container(
                          height: 50,
                          width: 340,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          // margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200]),
                          child: DropdownButton(
                            underline: SizedBox(),
                            value: serviceValue,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: serviceList.map((item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),

                            onChanged: (String? newValue) {
                              setState(() {
                                serviceValue = newValue!;
                                print(serviceValue);
                              });
                            },
                            hint: Text("Select Service"),
                          ),
                        ),
                      ]),
                ),
              if (widget.type == "Service Provider")
                Container(
                  margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 15, bottom: 10),
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.black45),
                            )),
                        Container(
                          height: 150,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            minLines: 6,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              // alignLabelWithHint: true,
                              hintText: 'Write about your self.',
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
                            ),
                          ),
                        ),
                      ]),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: widget.type == "Service Provider" ? 15 : 35),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          primary: Color(0xffF2861E),
                          backgroundColor: Colors.white,
                          side:
                              BorderSide(width: 3.5, color: Color(0xffF2861E)),
                          minimumSize: Size(150, 50)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    // child: OutlinedButton(
                    //   style: ,
                    // ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: widget.type == "Service Provider" ? 15 : 35),
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xffF2861E),
                          minimumSize: Size(150, 50)),
                      onPressed: () {
                        updateUser(widget.id.toString());
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
