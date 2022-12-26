import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/my_provider.dart';
import 'package:news_app/tab_screen.dart';
import 'package:provider/provider.dart';

import 'articles_screen.dart';
import 'category.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MyProvider(),
    child: MyApp(),
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
        colorScheme: ColorScheme.light(),
        primaryColor: Colors.deepPurple,
      ),
      home: TabsScreen(),
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
    List likedId = [];
    var map = Provider.of<MyProvider>(context, listen: false).map;
    map.forEach((key, value) {
      if (value == true) {
        likedId.add(key);
      }
    });
    // print(map.keys);
    // print(map.values);
    // print(likedId);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder<List<Category>>(
            future: futureCategory,
            builder: (context, snapshot) {
              List<Category>? items = snapshot.data;
              return items == null
                  ? Center(child: CircularProgressIndicator())
                  : Expanded(
                      child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ArticlesScreen(
                                            article: items[index],
                                          )));
                            },
                            child: GridTile(
                              // footer: IconButton(onPressed: toggleFavorite, icon: Icon(Icons.favorite)),
                              child: Container(
                                height: 200,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(items[index].image),
                                      fit: BoxFit.cover),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      items[index].title,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      iconSize: 40,
                                      onPressed: () {
                                        Provider.of<MyProvider>(context,
                                                listen: false)
                                            .toggleFavorite(items[index].id);
                                        var favoriteNews =
                                            Provider.of<MyProvider>(context,
                                                    listen: false)
                                                .favoriteNews;

                                        setState(() {
                                          favoriteNews.add(items[index]);
                                          for (var i in likedId) {
                                            if (items[index].id != likedId[i] || likedId.isEmpty) {
                                              favoriteNews.add(items[index]);
                                            }
                                          }

                                          map.forEach((key, value) {
                                            if (value == false) {
                                              favoriteNews.remove(items[index]);
                                            }
                                          });
                                        });
                                      },
                                      icon: (Provider.of<MyProvider>(context)
                                              .isFavorite(items[index].id)
                                          ? Icon(Icons.favorite)
                                          : Icon(Icons.favorite_border)),
                                      color: Colors.red[500],
                                    ),
                                  ],
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
