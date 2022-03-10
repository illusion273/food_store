// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as String,
      timeStamp: json['timeStamp'] as String?,
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'location': instance.location,
      'items': instance.items,
      'total': instance.total,
      'timeStamp': instance.timeStamp,
    };
