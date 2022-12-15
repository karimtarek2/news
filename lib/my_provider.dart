import 'package:flutter/material.dart';

class MyProvider with ChangeNotifier {
  final map = Map<int, bool>();

  bool isFavorite(int id) {
    return map[id] ?? false;
  }

  MyProvider();

  void toggleFavorite(int id) {
    final isFavorite = map[id] ?? false;

    map[id] = !isFavorite;

    notifyListeners();
  }
}
