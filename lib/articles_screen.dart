import 'package:flutter/material.dart';
import 'package:news_app/my_provider.dart';
import 'package:provider/provider.dart';

import 'category.dart';

class ArticlesScreen extends StatefulWidget {
  ArticlesScreen(
      {Key? key,
      required this.article,
      //this.toggleFavorite,
      })
      : super(key: key);
  final Category article;

  //final toggleFavorite;
  //final isFavorite;

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  // bool isFavorite = false;
  // void toggleFavorite() {
  //   setState(() {
  //     if (isFavorite) {
  //       isFavorite = false;
  //     } else {
  //       isFavorite = true;
  //     }
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<MyProvider>(context,listen: false).toggleFavorite(widget.article.id);
        },
        foregroundColor: Colors.red[500],
        backgroundColor: Colors.pink[100],
        child: Provider.of<MyProvider>(context).isFavorite(widget.article.id)
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border),
      ),
      appBar: AppBar(
        title: Text(
          widget.article.title,
          maxLines: 2,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(widget.article.image),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.article.desc,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
