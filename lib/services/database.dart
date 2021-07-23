import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';

class ServiceDatabase {
  final String uid;

  ServiceDatabase(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  Future<void> savaUser(String name, String lastname, String dropDownRole, String email) async {
    return await userCollection.doc(uid).set({
      'name' : name,
      'lastname' : lastname,
      'role' : dropDownRole,
      'email' : email
    });
  }

  AppUserData _userFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    if(data == null) throw Exception("Utilisateur Inconnu");
    return AppUserData(
      uid: uid,
      name:snapshot['name'],
      lastname: snapshot['lastname'],
      email: snapshot['email'],
      dropDownRole: snapshot['role'],
    );
  }
  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }
}
