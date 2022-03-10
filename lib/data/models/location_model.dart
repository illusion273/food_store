import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class Location extends Equatable {
  final String streetNumber;
  final String route;
  final String locality;
  final String postalCode;
  final double lat;
  final double lng;
  final String doorBell;
  final String floor;
  final String more;

  const Location({
    this.streetNumber = "",
    this.route = "",
    this.locality = "",
    this.postalCode = "",
    this.lat = 0,
    this.lng = 0,
    this.doorBell = "",
    this.floor = "",
    this.more = "",
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  Location copyWith({
    String? streetNumber,
    String? route,
    String? locality,
    String? postalCode,
    double? lat,
    double? lng,
    String? doorBell,
    String? floor,
    String? more,
  }) {
    return Location(
      streetNumber: streetNumber ?? this.streetNumber,
      route: route ?? this.route,
      locality: locality ?? this.locality,
      postalCode: postalCode ?? this.postalCode,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      doorBell: doorBell ?? this.doorBell,
      floor: floor ?? this.floor,
      more: more ?? this.more,
    );
  }

  String get address => "$route $streetNumber, $locality, $postalCode";
  String get details => "Floor: $floor, Doorbell: $doorBell";

  @override
  List<Object?> get props => [
        streetNumber,
        route,
        locality,
        postalCode,
        lat,
        lng,
        doorBell,
        floor,
        more,
      ];
}
