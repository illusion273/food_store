// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String? ?? "",
      uid: json['uid'] as String? ?? "",
      prefLocation: json['prefLocation'] == null
          ? const Location()
          : Location.fromJson(json['prefLocation'] as Map<String, dynamic>),
      locations: (json['locations'] as List<dynamic>?)
              ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      orders: (json['orders'] as List<dynamic>?)
              ?.map((e) => Order.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'uid': instance.uid,
      'prefLocation': instance.prefLocation,
      'locations': instance.locations,
      'orders': instance.orders,
    };
