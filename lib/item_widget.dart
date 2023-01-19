import 'package:flutter/material.dart';
import 'package:news_app/category.dart';
import 'package:news_app/my_provider.dart';
import 'package:provider/provider.dart';

import 'articles_screen.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget(this.item, {super.key});

  final Category item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticlesScreen(article: item)));
      },
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: NetworkImage(item.image), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xaA000000),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Text(
                item.title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                // mini: true,
                // elevation: 0,
                // backgroundColor: Colors.white,
                onPressed: () {
                  Provider.of<MyProvider>(context, listen: false)
                      .toggleFavorite(item);
                },
                child: (Provider.of<MyProvider>(context).isFavorite(item.id)
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      )),
                // color: Colors.red[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
