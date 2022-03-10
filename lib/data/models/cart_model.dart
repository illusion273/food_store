import 'package:equatable/equatable.dart';

import 'item_model.dart';

class Cart extends Equatable {
  final List<Item> items = [];

  Cart();

  String get total {
    double total = items.fold(0, (total, item) => total + item.subTotal);
    return total.toStringAsFixed(2);
  }

  void addItems(Item item, int quantity) {
    for (int i = 0; i < quantity; i++) {
      items.add(item);
    }
  }

  void removeItems(Item itemToRemove) {
    items.removeWhere((item) => item == itemToRemove);
  }

  Map<Item, int> getItemMap() {
    Map<Item, int> itemMap = {};
    for (var item in items) {
      if (!itemMap.containsKey(item)) {
        itemMap[item] = 1;
      } else {
        itemMap[item] = itemMap[item]! + 1;
      }
    }
    return itemMap;
  }

  @override
  List<Object?> get props => [items];
}
