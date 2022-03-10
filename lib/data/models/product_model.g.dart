// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      title: json['title'] as String,
      basePrice: (json['basePrice'] as num).toDouble(),
      category: json['category'] as String,
      description: json['description'] as String? ?? "",
      img: json['img'] as String? ?? imgNull,
      optional: (json['optional'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'basePrice': instance.basePrice,
      'category': instance.category,
      'description': instance.description,
      'img': instance.img,
      'optional': instance.optional,
    };
