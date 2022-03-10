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
      print("USER REPOSITORY: \n" + data.toString());
      if (data != null) {
        user = User.fromJson(data);
        return user!;
      }
      throw Exception("Firestore entry was not created for the signed in user");
    });
  }

  Future postLocationData(Location location) async {
    if (user != null) {
      var ref = _db.collection("users").doc(user!.uid);
      await ref.set({
        'locations': FieldValue.arrayUnion([location.toJson()])
      }, SetOptions(merge: true));
    } else {
      throw Exception("Critical error: No user signed in to post data for");
    }
  }

  Future postOrderData(Order order) async {
    if (user != null) {
      var ref = _db.collection("users").doc(user!.uid);
      //var json = order.toJson();
      //json['timeStamp'] = FieldValue.serverTimestamp();
      //try {
      await ref.update(
        {
          'orders': order.toJson() //FieldValue.arrayUnion([order.toJson()])
        },
      );
      // } catch (e) {
      //   throw Exception(e);
      // }
    } else {
      throw Exception("Critical error: No user signed in to post data for");
    }
  }
}
// Future<void> postLocationData(Auth auth, Location location) async {
    
//     var ref = _db.collection("users").doc(auth.uid);

//     await ref.set({
//       'locations': FieldValue.arrayUnion([location.toJson()])
//     }, SetOptions(merge: true));
//   }