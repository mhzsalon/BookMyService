import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/Services/CallAPI.dart';
import 'package:frontend/models/user.dart';
import 'package:http/http.dart' as http;

final emailControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final passwordControllerProvider = Provider<TextEditingController>((ref) {
  return TextEditingController();
});

final loginProvider = FutureProvider<User>((ref) async {
  final baseUrl = CallApi();

  final email = ref.watch(emailControllerProvider).text;
  final password = ref.watch(passwordControllerProvider).text;

  final response = await http.post(
    Uri.parse('${baseUrl.url}/api/login/'),
    body: {'email': email, 'password': password},
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return User.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to log in');
  }
});
