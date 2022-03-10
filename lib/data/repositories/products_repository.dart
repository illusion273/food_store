import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductsRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Product> _products = const [];

  Future<List<Product>> getProducts() async {
    if (_products.isEmpty) {
      var ref = _db.collection("products");
      var snapshot = await ref.get();
      var data = snapshot.docs.map((doc) => doc.data());
      var products = data.map((e) => Product.fromJson(e));
      _products = products.toList();
    }
    return _products;
  }
}
