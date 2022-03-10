import 'package:food_store/data/models/category_model.dart';
import 'package:food_store/data/models/item_model.dart';
import 'package:food_store/data/models/product_model.dart';

class Catalog {
  final Map<String, List<Item>> catalogTiles;
  //Map<String, List<Product>> catalogTiles;
  const Catalog({this.catalogTiles = const {}});

  factory Catalog.generate(List<Category> categories, List<Product> products) {
    Map<String, List<Item>> temp = {};
    for (var category in categories) {
      List<Item> seperator = [];
      for (var product in products) {
        if (product.category == category.id) {
          List<Ingredient> ingredients = [];

          for (var ingredient in product.optional!) {
            ingredients.add(Ingredient(name: ingredient, selected: true));
          }

          category.extras!.forEach((key, value) {
            if (!ingredients.any((ingredient) => ingredient.name == key)) {
              ingredients
                  .add(Ingredient(name: key, price: value, selected: false));
            }
          });

          seperator.add(Item(
            id: product.id,
            title: product.title,
            description: product.description!,
            img: product.img!,
            basePrice: product.basePrice,
            ingredients: ingredients,
          ));
        }
      }
      temp[category.title] = seperator;
    }
    return Catalog(catalogTiles: temp);
  }

  Catalog copyWith({Map<String, List<Item>>? catalogTiles}) {
    return Catalog(catalogTiles: catalogTiles ?? this.catalogTiles);
  }
}
