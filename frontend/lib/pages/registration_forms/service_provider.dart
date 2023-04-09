import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:frontend/API/CallAPI.dart';
import 'package:frontend/pages/login/login.dart';
import 'package:http/http.dart';
import 'dart:convert';

class ServiceProvider extends StatefulWidget {
  const ServiceProvider({super.key});

  @override
  State<ServiceProvider> createState() => _ServiceProviderState();
}

class _ServiceProviderState extends State<ServiceProvider> {
  String? dropdownvalue;
  String? serviceValue;
  TextEditingController _spEmailController = new TextEditingController();
  TextEditingController _spPasswordController = new TextEditingController();
  TextEditingController _confirmPW = new TextEditingController();
  TextEditingController _spNameController = new TextEditingController();
  TextEditingController _spLocationController = new TextEditingController();

  TextEditingController _spPhoneController = new TextEditingController();
  TextEditingController _priceController = new TextEditingController();

  bool passVerified = true;
  CallApi obj = CallApi();

  spRegistration() async {
    try {
      Response response = await post(
        Uri.parse(obj.url + "/api/register/"),
        body: {
          'email': _spEmailController.text.toString(),
          'password': _spPasswordController.text.toString(),
          'location': _spLocationController.text.toString(),
          'phone': "+977 " + _spPhoneController.text.toString(),
          'name': _spNameController.text.toString(),
          'gender': dropdownvalue.toString(),
          'user_type': 'Service Provider',
          'price': _priceController.text.toString(),
          'service': serviceValue.toString(),
        },
      );
      var registerDetail = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Success',
          desc: 'Registration Successfull.',
          buttonsTextStyle: const TextStyle(color: Colors.black),
          showCloseIcon: true,
          btnOkOnPress: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ).show();
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
  var serviceList = [
    'Cleaner',
    'Carpenter',
    'Babysitter',
    'Painter',
    'Electrician',
    'Elderly care',
    'Plumber',
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
            margin: EdgeInsets.only(left: 25, right: 25, top: 30),
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: _spNameController,
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
                controller: _spEmailController,
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

          // gender and phone number
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
                        controller: _spPhoneController,
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

          // rate and service type
          Container(
            margin: EdgeInsets.only(top: 10, left: 35, right: 40),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 50,
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
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 50,
                    // alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: _priceController,
                        decoration: InputDecoration(
                            hintText: "Price",
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
                controller: _spPasswordController,
                decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.black45,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: passVerified == false
                              ? Colors.redAccent
                              : Colors.grey.shade200,
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
                controller: _confirmPW,
                decoration: InputDecoration(
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(
                      color: Colors.black45,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: passVerified == false
                              ? Colors.redAccent
                              : Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffF2861E),
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
            margin: EdgeInsets.only(top: 10),
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
                spRegistration();

                if (_spPasswordController == _confirmPW) {
                  print('pressed');
                } else {
                  setState(() {
                    passVerified = true;
                  });
                }
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
          )
        ],
      ),
    );
  }
}
