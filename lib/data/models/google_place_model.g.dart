// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_place_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      addressComponents: (json['address_components'] as List<dynamic>)
          .map((e) => _AddressComponents.fromJson(e as Map<String, dynamic>))
          .toList(),
      geometry: _Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'address_components': instance.addressComponents,
      'geometry': instance.geometry,
    };

_AddressComponents _$AddressComponentsFromJson(Map<String, dynamic> json) =>
    _AddressComponents(
      longName: json['long_name'] as String,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AddressComponentsToJson(_AddressComponents instance) =>
    <String, dynamic>{
      'long_name': instance.longName,
      'types': instance.types,
    };

_Geometry _$GeometryFromJson(Map<String, dynamic> json) => _Geometry(
      location: _Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeometryToJson(_Geometry instance) => <String, dynamic>{
      'location': instance.location,
    };

_Location _$LocationFromJson(Map<String, dynamic> json) => _Location(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );

Map<String, dynamic> _$LocationToJson(_Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };
