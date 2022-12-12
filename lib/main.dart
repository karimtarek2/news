import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'articles_screen.dart';
import 'category.dart';

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
      appBar: AppBar(
        title: Text('News'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Category>>(
            future: futureCategory,
            builder: (context, snapshot) {
              List<Category>? item = snapshot.data;
              return item == null
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => ArticlesScreen(
                                    articleDesc: item[index].desc,
                                      articleTitle: item[index].title,
                                      articleImage: item[index].image,
                                  )));
                            },
                            child: GridTile(
                              child: Container(
                                height: 200,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(item[index].image),
                                      fit: BoxFit.cover),
                                ),
                                child: Text(
                                  item[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
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
