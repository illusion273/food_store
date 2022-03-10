import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

const String imgNull =
    "https://firebasestorage.googleapis.com/v0/b/food-store-83ff6.appspot.com/o/placeholder.jpg?alt=media&token=410b74d6-1253-4800-970d-1d241ff9f8c9";

@JsonSerializable()
class Product {
  final String id;
  final String title;
  final double basePrice;
  final String category;
  final String? description;
  final String? img;
  final List<String>? optional;

  const Product({
    required this.id,
    required this.title,
    required this.basePrice,
    required this.category,
    this.description = "",
    this.img = imgNull,
    this.optional = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

//        "https://firebasestorage.googleapis.com/v0/b/food-store-83ff6.appspot.com/o/placeholder.jpg?alt=media&token=410b74d6-1253-4800-970d-1d241ff9f8c9",
