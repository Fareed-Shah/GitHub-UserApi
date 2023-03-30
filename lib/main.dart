import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // api link
  final String apiuser = 'Fareed-Shah';
  var url = "https://api.github.com/users/";
  String? userName;

  // api calling function
  callApi() async {
    var uri = Uri.parse(url + "$apiuser");
    setState(() {
      userName = null;
    });

    try {
      var responce = await http.get(uri);
      // print(responce.body);
      var responceString = responce.body;
      Map<String, dynamic> parsed = jsonDecode(responceString);
      setState(() {
        userName = parsed["name"];
        // print(parsed["name"]);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub API'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            userName != null
                ? Text(userName!)
                : const CircularProgressIndicator(
                    color: Colors.green,
                    // backgroundColor: Colors.lightBlue,
                    strokeWidth: 8.0,
                  ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: 50,
              width: 150,
              color: Colors.green,
              child: ElevatedButton(
                  onPressed: () {
                    callApi();
                  },
                  child: const Text('clik to call api')),
            )
          ],
        ),
      ),
    );
  }
}
