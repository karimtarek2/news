import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/item_widget.dart';
import 'package:news_app/my_provider.dart';
import 'package:news_app/tab_screen.dart';
import 'package:provider/provider.dart';

import 'articles_screen.dart';
import 'category.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MyProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        primaryColor: Colors.deepPurple,
      ),
      home: const TabsScreen(),
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
    final url = Uri.parse("https://api.jsonserve.com/Ryt92T");
    var response = await http.get(url);

    var jsonString = response.body;
    List<Category> categories = categoryFromJson(jsonString);

    return categories;
  }

  late Future<List<Category>> futureCategory = getCategories();

  @override
  void initState() {
    super.initState();
    futureCategory = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Category>>(
            future: futureCategory,
            builder: (context, snapshot) {
              List<Category>? items = snapshot.data;
              return items == null
                  ? const Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => ArticlesScreen(article: item)));
                            },
                            child: ItemWidget(item),
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
