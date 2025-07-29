import 'dart:convert';

import 'package:api/model/modelClass.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Screenuser extends StatefulWidget {
  const Screenuser({super.key});

  @override
  State<Screenuser> createState() => _ScreenuserState();
}

class _ScreenuserState extends State<Screenuser> {
  List<userClass> postList = [];

  Future<List<userClass>> getPostApi() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        postList.add(userClass.fromJson(i));
      }

      return postList;
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Api Call ")),
      body: Column(
        children: [FutureBuilder(future: future, builder: builder)],
      ),
    );
  }
}
