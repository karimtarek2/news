import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/category.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(),
        primaryColor: Colors.deepPurple,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Category>> getCategories() async {
    Uri url = "https://api.jsonserve.com/Ryt92T" as Uri;
    var response = await http.get(url);
    var jsonString = response.body;

    List<Category> categories = categoryFromJson(jsonString);
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FutureBuilder<List<Category>>(
            future: getCategories(),
            builder: (context, snapshot) {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].toString()),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
