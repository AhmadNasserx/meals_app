import 'package:flutter/material.dart';

class Category {
  const Category({
      required this.id,
      required this.title,
      this.color = Colors.orange,
  });

  final dynamic id;
  final dynamic title;
  final dynamic color;
}