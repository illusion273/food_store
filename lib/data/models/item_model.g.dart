// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      id: json['id'] as String,
      title: json['title'] as String,
      basePrice: (json['basePrice'] as num).toDouble(),
      description: json['description'] as String,
      img: json['img'] as String,
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((e) => Ingredient.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'basePrice': instance.basePrice,
      'description': instance.description,
      'img': instance.img,
      'ingredients': instance.ingredients,
    };

Ingredient _$IngredientFromJson(Map<String, dynamic> json) => Ingredient(
      name: json['name'] as String,
      price: (json['price'] as num?)?.toDouble() ?? 0,
      selected: json['selected'] as bool,
    );

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'selected': instance.selected,
    };
