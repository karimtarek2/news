import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'category.dart';

class MyProvider with ChangeNotifier {
  String name = '';

  final map = Map<int, bool>();
  final tagMap = Map<int, String>();

  List<Category> favoriteNews = [];

  late Future<List<Category>> futureCategory = getCategories();

  Future<List<Category>> getCategories() async {
    final url = Uri.parse("https://api.jsonserve.com/Ryt92T");
    var response = await http.get(url);

    var jsonString = response.body;

    List<Category> categories = categoryFromJson(jsonString);

    return categories;
  }

  bool isFavorite(int id) {
    return map[id] ?? false;
  }

  List<Category> trueKeys = [];

  void addTags(int id, String tags) {
    tagMap.addAll({id: tags});
  }

  String tag = '';

  String? tags(int id) {
    if (tagMap[id] == null) {
      tagMap[id] = tag;
    } else {
      tagMap.forEach((key, value) {
        if (id == key) {
          tagMap[id];
        }
      });
    }

    return tagMap[id];
  }

  void toggleFavorite(Category item) {
    final isFavorite = map[item.id] ?? false;
    map[item.id] = !isFavorite;

    if (isFavorite) {
      favoriteNews.remove(item);
    } else {
      favoriteNews.add(item);
    }

    notifyListeners();
  }
}
