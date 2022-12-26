import 'package:flutter/material.dart';
import 'package:news_app/item_widget.dart';
import 'package:news_app/my_provider.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyProvider>(context, listen: true);
    var favoriteNews = provider.favoriteNews;

    if (favoriteNews.isEmpty) {
      return const Center(
        child: Text('no favorite'),
      );
    } else {
      return Scaffold(
        body: ListView.builder(
            itemCount: favoriteNews.length,
            itemBuilder: (context, index) {
              final item = favoriteNews[index];
              return ItemWidget(item);
            }),
      );
    }
  }
}
