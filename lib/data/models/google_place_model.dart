import 'package:json_annotation/json_annotation.dart';

part 'google_place_model.g.dart';

/// Models Google Places Details
class GooglePlace {
  const GooglePlace({
    this.streetNumber,
    this.route,
    this.locality,
    this.postalCode,
    this.lat,
    this.lng,
  });

  final String? streetNumber;
  final String? route;
  final String? locality;
  final String? postalCode;
  final double? lat;
  final double? lng;

  factory GooglePlace.fromJson(Map<String, dynamic> json) {
    Result result = Result.fromJson(json);
    final routeComponent =
        result.addressComponents.where((c) => c.types.contains('route'));
    final streetNumberComponent = result.addressComponents
        .where((c) => c.types.contains('street_number'));
    final localityComponent =
        result.addressComponents.where((c) => c.types.contains('locality'));
    final postalCodeComponent =
        result.addressComponents.where((c) => c.types.contains('postal_code'));
    final lat = result.geometry.location.lat;
    final lng = result.geometry.location.lng;

    return GooglePlace(
      route: routeComponent.isNotEmpty ? routeComponent.first.longName : null,
      streetNumber: streetNumberComponent.isNotEmpty
          ? streetNumberComponent.first.longName
          : null,
      locality: localityComponent.isNotEmpty
          ? localityComponent.first.longName
          : null,
      postalCode: postalCodeComponent.isNotEmpty
          ? postalCodeComponent.first.longName
          : null,
      lat: lat,
      lng: lng,
    );
  }

  factory GooglePlace.fromResult(Result result) {
    final routeComponent =
        result.addressComponents.where((c) => c.types.contains('route'));
    final streetNumberComponent = result.addressComponents
        .where((c) => c.types.contains('street_number'));
    final localityComponent =
        result.addressComponents.where((c) => c.types.contains('locality'));
    final postalCodeComponent =
        result.addressComponents.where((c) => c.types.contains('postal_code'));
    final lat = result.geometry.location.lat;
    final lng = result.geometry.location.lng;

    return GooglePlace(
      route: routeComponent.isNotEmpty ? routeComponent.first.longName : null,
      streetNumber: streetNumberComponent.isNotEmpty
          ? streetNumberComponent.first.longName
          : null,
      locality: localityComponent.isNotEmpty
          ? localityComponent.first.longName
          : null,
      postalCode: postalCodeComponent.isNotEmpty
          ? postalCodeComponent.first.longName
          : null,
      lat: lat,
      lng: lng,
    );
  }
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Result {
  final List<_AddressComponents> addressComponents;
  final _Geometry geometry;
  const Result({
    required this.addressComponents,
    required this.geometry,
  });

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class _AddressComponents {
  final String longName;
  final List<String> types;

  const _AddressComponents({
    required this.longName,
    required this.types,
  });

  factory _AddressComponents.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentsFromJson(json);
}

@JsonSerializable()
class _Geometry {
  final _Location location;

  const _Geometry({
    required this.location,
  });

  factory _Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
}

@JsonSerializable()
class _Location {
  final double lat;
  final double lng;

  const _Location({
    required this.lat,
    required this.lng,
  });

  factory _Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
