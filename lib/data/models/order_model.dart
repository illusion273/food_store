import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location_model.dart';
import 'item_model.dart';

part 'order_model.g.dart';

// Money transfer is not a future of the application at it's current state

@JsonSerializable()
class Order extends Equatable {
  final Location location;
  final List<Item> items;
  final String total;
  final String? timeStamp;

  const Order({
    required this.location,
    required this.items,
    required this.total,
    this.timeStamp,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @override
  List<Object?> get props => [location, items, total, timeStamp];
}
