import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';

class ServiceDatabase {
  final String uid;

  ServiceDatabase(this.uid);

  final CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> savaUser(String name, String lastname) async {
    return await userCollection.doc(uid).set({
      'name' : name,
      'lastname' : lastname
    });
  }

  AppUserData _userFromSnapshot(DocumentSnapshot snapshot) {
    return AppUserData(
      uid: uid,
      name:snapshot['name'],
      lastname: snapshot['lastname']
    );
  }
  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }
}
