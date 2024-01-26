import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/model/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Rest API call"),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final email = user.name.first;
            final color = user.gender == "female" ? Colors.greenAccent : Colors.blue[100];
            return Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: ListTile(
                  leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue,
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )),
                  title: Text(email,
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                  subtitle: Text(user.phone),
                  tileColor: color,
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: fetchUsers,
        child: Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(23.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void fetchUsers() async {
    print("fetch users called");
    const url = "https://randomuser.me/api/?results=100";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json["results"] as List<dynamic>;
    final transformed = results.map((e) {
      final name = UserName(
        title: e["name"]["title"],
        first: e["name"]["first"],
        last: e["name"]["last"],
      );
      return User(
        gender: e["cell"],
        email: e["email"],
        cell: e["gender"],
        nat: e["nat"],
        phone: e["phone"],
        name: name,
      );
    }).toList();

    setState(() {
      users = transformed;
    });

    print("Fetch users completed");
  }
}
