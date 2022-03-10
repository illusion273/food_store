import 'package:json_annotation/json_annotation.dart';

part 'category_model.g.dart';

@JsonSerializable()
class Category {
  final String id;
  final String title;
  final int index;
  final Map<String, double>? extras;
  //final Map<String, Map<String, dynamic>> igredients;

  Category({
    required this.id,
    required this.title,
    required this.index,
    this.extras = const {},
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  // List<Ingredient> addIgredientsToProduct() {
  //   return igredients.entries.map((e) {
  //     return Ingredient(
  //       name: e.key,
  //       index: e.value["index"],
  //       price: e.value["price"].toDouble(),
  //     );
  //   }).toList();
  // }
}
