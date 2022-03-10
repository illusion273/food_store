import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/category_model.dart';

class CategoryRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Category> _categories = const [];

  Future<List<Category>> getCategories() async {
    if (_categories.isEmpty) {
      var ref = _db.collection("categories").orderBy("index");
      var snapshot = await ref.get();
      var data = snapshot.docs.map((doc) => doc.data());
      var categories = data.map((e) => Category.fromJson(e));
      _categories = categories.toList();
    }
    return _categories;
  }
}
