import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';

class ServiceDatabase {
  final String uid;

  ServiceDatabase(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> savaUser(String name) async {
    return await userCollection.doc(uid).set({
      'name' : name
    });
  }

 /* AppUserData _userFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("user not found");
    return AppUserData(
      uid: uid,
      name: data['name']
    );
  }
*/
/*
  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }*/
}
