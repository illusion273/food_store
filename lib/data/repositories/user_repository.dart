import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_store/data/models/location_model.dart';
import 'package:food_store/data/models/order_model.dart';
import 'package:food_store/data/models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late User? user;

  Stream<User> getUserData(String uid) {
    var documentStream = _db.collection('users').doc(uid).snapshots();
    return documentStream.map((snapshot) {
      var data = snapshot.data();

      if (data != null) {
        user = User.fromJson(data);
        print("USER REPOSITORY:\n");
        print(user.toString());
        return user!;
      }
      throw Exception("Firestore entry was not created for the signed in user");
    });
  }

  Future postLocationData(Location location) async {
    if (user != null) {
      try {
        var ref = _db.collection("users").doc(user!.uid);
        var json = location.toJson();
        await ref.update({
          'locations': FieldValue.arrayUnion([json]),
          'prefLocation': json
        });
      } catch (e) {
        throw Exception("Failed to post location data");
      }
    } else {
      throw Exception("No user signed in to post data for");
    }
  }

  Future postOrderData(Order order) async {
    if (user != null) {
      try {
        var ref = _db.collection("users").doc(user!.uid);
        await ref.update({
          'orders': FieldValue.arrayUnion([order.toJson()]),
          'prefLocation': order.location.toJson(),
        });
      } catch (e) {
        throw Exception("Failed to post order data");
      }
    } else {
      throw Exception("No user signed in to post data for");
    }
  }
}
