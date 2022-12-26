import 'package:flutter/material.dart';
import 'package:news_app/main.dart';

import 'favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final titles = ['Category', 'Favorite'];

  int selectedPageIndex = 0;

  void selectPage(int value) {
    setState(() {
      selectedPageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selectedPageIndex]),
      ),
      body: IndexedStack(
        index: selectedPageIndex,
        children: const [
          Home(),
          FavoriteScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedPageIndex,
        onTap: selectPage,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        ],
      ),
    );
  }
}
