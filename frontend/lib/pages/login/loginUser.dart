import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart';
import 'package:frontend/pages/landing_page.dart';


login(String email, String password) async {
  try {
    Response response =
        await post(Uri.parse("http://10.0.2.2:8000/api/login/"), body: {
      'email': email,
      'password': password,
    });

    return response.statusCode;
    var data = jsonDecode(response.body.toString());
    List userdata = [data['user_data']];

    print(data);
    print(userdata[0]);
  } catch (e) {
    print("fick");
    print("Error is $e");
  }
}
