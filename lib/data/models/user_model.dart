import 'package:food_store/data/models/location_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'order_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String email;
  final String uid;
  final List<Location> locations;
  final List<Order> orders;
  const User({
    this.email = "",
    this.uid = "",
    this.locations = const [],
    this.orders = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
