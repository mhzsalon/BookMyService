import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  String dropdownvalue = 'Male';

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
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),

                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownvalue = newValue!;
                        });
                      },
                      value: dropdownvalue,
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
                  backgroundColor: Color(0xffF5591F),
                  minimumSize: Size(320, 53)),
              onPressed: () {},
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
                    style: TextStyle(color: new Color(0xffF5591F)),
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
