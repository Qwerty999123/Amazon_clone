import 'dart:convert';

import 'package:amazon_app/models/rating.dart';

class Product{
  final String name;
  final String description;
  final double price;
  final int quantity;
  final List<String> images;
  final String category;
  final String? id;
  List<Rating>? rating;

  Product({
    required this.name, 
    required this.description, 
    required this.price, 
    required this.quantity, 
    required this.images, 
    required this.category,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      id: map['_id'],
      rating: map['ratings'] != null 
          ? List<Rating>.from(
            map['ratings']?.map(
              (x) => Rating.fromMap(x),
            ),
          )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
  
}