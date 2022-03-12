import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class Item extends Equatable {
  final String id;
  final String title;
  final double basePrice;
  final String description;
  final String img;
  final List<Ingredient> ingredients;

  const Item({
    required this.id,
    required this.title,
    required this.basePrice,
    required this.description,
    required this.img,
    required this.ingredients,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  Item copyWith({
    String? title,
    String? id,
    double? basePrice,
    String? description,
    String? img,
    List<Ingredient>? ingredients,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      basePrice: basePrice ?? this.basePrice,
      description: description ?? this.description,
      img: img ?? this.img,
      ingredients: ingredients ?? List.from(this.ingredients),
    );
  }

  const Item.empty()
      : this(
          id: "",
          title: "",
          basePrice: 0,
          description: "",
          img: "",
          ingredients: const [],
        );

  String ingredientsToSingleString() {
    String single = "";
    for (var ingredient in ingredients) {
      if (ingredient.selected == true) {
        single += (ingredient.name + "\n");
      }
    }
    single = single.substring(0, single.length - 1);
    return single;
  }

  double get subTotal {
    var subTotal = basePrice;
    for (var ingredient in ingredients) {
      if (ingredient.selected) {
        subTotal += ingredient.price;
      }
    }
    return subTotal;
  }

  @override
  List<Object?> get props =>
      [id, title, description, img, basePrice, ingredients];
}

@JsonSerializable()
class Ingredient extends Equatable {
  final String name;
  final double price;
  final bool selected;

  const Ingredient({
    required this.name,
    this.price = 0,
    required this.selected,
  });

  Ingredient copyWith({String? name, double? price, bool? selected}) {
    return Ingredient(
        name: name ?? this.name,
        price: price ?? this.price,
        selected: selected ?? this.selected);
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) =>
      _$IngredientFromJson(json);

  Map<String, dynamic> toJson() => _$IngredientToJson(this);

  Ingredient clone() {
    return Ingredient(
      name: name,
      price: price,
      selected: selected,
    );
  }

  @override
  List<Object?> get props => [name, price, selected];
}
