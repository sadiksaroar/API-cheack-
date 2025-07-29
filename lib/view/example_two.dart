import 'dart:convert';

import 'package:api/model/photos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTwoApi extends StatefulWidget {
  const ExampleTwoApi({super.key});

  @override
  State<ExampleTwoApi> createState() => _ExampleTwoApiState();
}

class _ExampleTwoApiState extends State<ExampleTwoApi> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos() async {
    final response = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/photos"),
    );
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i["title"], url: i["url"], id: i["id"]);
        photosList.add(photos);
      }
      return photosList;
    }
    return photosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Api Course")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotos(),

              builder: (context, snapshot) {
                return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data![index].url.toString(),
                        ),
                      ),
                      // subtitle: Text(snapshot.data![index].id.toString()),
                      title: Text(snapshot.data![index].title.toString()),
                      subtitle: Text(snapshot.data![index].id.toString()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
