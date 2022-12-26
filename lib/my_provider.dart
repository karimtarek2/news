import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'category.dart';

class MyProvider with ChangeNotifier {
  final map = Map<int, bool>();

  Future<List<Category>> getCategories() async {
    final url = Uri.parse("https://api.jsonserve.com/Ryt92T");
    var response = await http.get(url);

    var jsonString = response.body;

    List<Category> categories = categoryFromJson(jsonString);

    return categories;
  }

  late Future<List<Category>> futureCategory = getCategories();

  bool isFavorite(int id) {
    return map[id] ?? false;
  }

  MyProvider();

  List<Category> favoriteNews = [];

  List<Category> trueKeys = [];



  void toggleFavorite(int id) {
    var isFavorite = map[id] ?? false;

    map[id] = !isFavorite;

    notifyListeners();
  }
}
