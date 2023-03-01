import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SpList extends StatefulWidget {
  const SpList({super.key});

  @override
  State<SpList> createState() => _SpListState();
}

class _SpListState extends State<SpList> {
  fetchSp(String params) async {
    try{
      Response response = await get(
        Uri.parse("http://10.0.2.2:8000/api/service_provider/?service=cleaner"),

      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
