import 'package:flutter/material.dart';

class MProduct {
  // 'title': 'Product D',
  // 'price': 17.0,
  // 'description': 'this is just description D',
  // 'image':
  MProduct(
    {
      this.id,
      @required this.title,
      @required this.price,
      @required this.description,
      @required this.image
    }
  );

  String id;
  String title;
  double price;
  String description;
  String image;
}
