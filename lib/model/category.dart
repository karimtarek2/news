import 'package:flutter/material.dart';

import 'dart:convert';

List<Category> categoryFromJson(jsonString) =>
    List<Category>.from(json.decode(jsonString).map((item) => Category.fromJson(item)));

class Category {
  Category({
    this.id,
    this.title,
    this.image,
    this.desc,
  });

  int? id;
  String? title;
  String? image;
  String? desc;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        desc: json["desc"],
      );
}
Category fromJson(String jsonString){
  final parsedJson = json.decode(jsonString);
  return Category.fromJson(parsedJson);
}