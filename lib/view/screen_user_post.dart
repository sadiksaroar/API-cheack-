import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Screenuser extends StatefulWidget {
  const Screenuser({super.key});

  @override
  State<Screenuser> createState() => _ScreenuserState();
}

class _ScreenuserState extends State<Screenuser> {
  Future<List<User>> getPostApi() async {
    try {
      final response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception(
          'Failed to load posts: Status code ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Failed to load posts: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("API Call")),
      body: FutureBuilder<List<User>>(
        future: getPostApi(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {}); // Retry fetching data
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No posts available'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final post = snapshot.data![index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(
                    post.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(post.body),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class User {
  final int userId;
  final int id;
  final String title;
  final String body;

  User({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["userId"] as int,
      id: json["id"] as int,
      title: json["title"] as String,
      body: json["body"] as String,
    );
  }
}
