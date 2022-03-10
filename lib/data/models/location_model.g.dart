// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      streetNumber: json['streetNumber'] as String? ?? "",
      route: json['route'] as String? ?? "",
      locality: json['locality'] as String? ?? "",
      postalCode: json['postalCode'] as String? ?? "",
      lat: (json['lat'] as num?)?.toDouble() ?? 0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0,
      doorBell: json['doorBell'] as String? ?? "",
      floor: json['floor'] as String? ?? "",
      more: json['more'] as String? ?? "",
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'streetNumber': instance.streetNumber,
      'route': instance.route,
      'locality': instance.locality,
      'postalCode': instance.postalCode,
      'lat': instance.lat,
      'lng': instance.lng,
      'doorBell': instance.doorBell,
      'floor': instance.floor,
      'more': instance.more,
    };
