import 'package:http/http.dart';
import 'dart:convert';

class CallApi {
  final String _url = "http://10.0.2.2:8000/api/";

  postData(data, apiUrl) async{
    var full_url = _url + apiUrl;
    return await post(
      Uri.parse(full_url),
      body: jsonEncode(data),
    );
  }
}
