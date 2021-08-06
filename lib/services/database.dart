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
/*
  Stream<RoleData> get role {
    return roleCollection.doc(uid).snapshots().map(_roleFromSnapshot);
  }
  Future<void> savaRole(bool jeune, bool admin, bool expert, bool direction, bool mentor) async {
    return await roleCollection.doc(uid).set({
      'admin': admin,
      'jeune': jeune,
      'expert': expert,
      'mentor': mentor,
      'direction': direction,
    },
      SetOptions(merge: true),
    );
  }

  RoleData _roleFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    if(data == null) throw Exception("Utilisateur Inconnu");
    return RoleData(
      uid: uid,
      admin: snapshot['admin'],
      jeune: snapshot['jeune'],
      expert: snapshot['expert'],
      mentor: snapshot['mentor'],
      direction: snapshot['direction']
    );
  }*/

}
