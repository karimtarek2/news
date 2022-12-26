import 'package:flutter/material.dart';
import 'package:news_app/my_provider.dart';
import 'package:provider/provider.dart';

import 'articles_screen.dart';
import 'category.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    var map = Provider.of<MyProvider>(context, listen: false).map;
    var favoriteNews =
        Provider.of<MyProvider>(context, listen: false).favoriteNews;

    List<int> trueKeys = [];
    //List<int> falseKeys = [];
    map.forEach((k, v) {
      if (v == true) {
        trueKeys.add(k);
        // } else if (v == false) {
        //   falseKeys.add(k);
      }
    });

    if (favoriteNews.isEmpty) {
      return Center(
        child: Text('no favorite'),
      );
    } else {
      return Scaffold(
        body: ListView.builder(
            itemCount: Provider.of<MyProvider>(context, listen: false)
                .favoriteNews
                .length,
            itemBuilder: (context, index) {
              var item = Provider.of<MyProvider>(context, listen: false)
                  .favoriteNews[index];

              return GridTile(
                // footer: IconButton(onPressed: toggleFavorite, icon: Icon(Icons.favorite)),
                child: Container(
                  height: 200,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(item.image), fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }
}
