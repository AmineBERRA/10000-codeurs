import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';

class ServiceDatabase {
  final String uid;

  ServiceDatabase(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }

  Future<void> saveUser(
      String name, String lastname, String email, String role) async {
    return await userCollection.doc(uid).set(
      {'name': name, 'lastname': lastname, 'email': email, 'role': role},
    );
  }

  AppUserData _userFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("Utilisateur Inconnu");
    return AppUserData(
        uid: uid,
        name: snapshot['name'],
        lastname: snapshot['lastname'],
        email: snapshot['email'],
        role: snapshot['role']);
  }

}
