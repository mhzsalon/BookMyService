import 'package:flutter/material.dart';
import 'package:frontend/pages/confirm_booking.dart';
import 'package:frontend/pages/login/login.dart';
import 'package:frontend/pages/notification.dart';
import 'package:frontend/pages/register.dart';
import 'package:frontend/pages/sp_profile.dart';
import 'package:frontend/pages/manage_profile.dart';
import 'package:http/http.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:convert';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  String? dropdownvalue;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _locationController = new TextEditingController();

  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _userController = new TextEditingController();

  userRegistration() async {
    try {
      Response response = await post(
        Uri.parse("http://10.0.2.2:8000/api/register/"),
        body: {
          'email': _emailController.text.toString(),
          'password': _passwordController.text.toString(),
          'location': _locationController.text.toString(),
          'phone': "+977 " + _phoneController.text.toString(),
          'name': _nameController.text.toString(),
          'gender': dropdownvalue.toString(),
          'user_type': 'Clients',
        },
      );
      var registerDetail = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } else {
        print(
          registerDetail["message"],
        );
      }
    } catch (e) {
      print("Error is $e");
    }
  }

  // List of items in our dropdown menu
  var items = [
    'Male',
    'Female',
    'Other',
  ];

  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 0),
      child: Column(
        children: [
          //full name
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 25, right: 25, top: 40),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: "Full name",
                    hintStyle: TextStyle(
                      color: Colors.black45,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: new Color(0xffF5591F),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
          ),

          //Email
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 25, right: 25, top: 10),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.black45,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: new Color(0xffF5591F),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 10, left: 35, right: 28),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    // margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[200]),
                    child: DropdownButton(
                      underline: SizedBox(),
                      value: dropdownvalue,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),

                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                      hint: Text("Gender"),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 50,
                    // margin: EdgeInsets.only(left: 25, right: 25, top: 10),
                    // alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                            hintText: "Phone number",
                            hintStyle: TextStyle(
                              color: Colors.black45,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade200,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: new Color(0xffF5591F),
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            fillColor: Colors.grey[200],
                            filled: true),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          //password
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 25, right: 25, top: 10),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.black45,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: new Color(0xffF5591F),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
          ),

          //Confirm password
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 25, right: 25, top: 10),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(
                      color: Colors.black45,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: new Color(0xffF5591F),
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.grey[200],
                    filled: true),
              ),
            ),
          ),

          //checkbox
          Container(
            margin: EdgeInsets.only(top: 5, left: 35),
            child: Row(
              children: [
                Checkbox(
                  value: isChecked,
                  activeColor: Colors.orangeAccent,
                  onChanged: (newBool) {
                    setState(() {
                      isChecked = newBool;
                    });
                  },
                ),
                Container(
                  child: Text(
                    "I agree to all terms and conditions.",
                    style: TextStyle(color: Colors.black45, fontSize: 14),
                  ),
                )
              ],
            ),
          ),

          //Register button
          Container(
            margin: EdgeInsets.only(top: 40),
            padding: EdgeInsets.only(left: 5, right: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xffF2861E),
                  minimumSize: Size(320, 53)),
              onPressed: () {
                userRegistration();
                print("pressed");
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => SP_profile()));
              },
              child: Text(
                "Register",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          ),

          //login link
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text(
                    " Login",
                    style: TextStyle(color: Color(0xffF2861E)),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
