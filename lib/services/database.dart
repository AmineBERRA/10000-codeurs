import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';
import 'package:stage_10000_codeurs/screens/home/Admin/homeScreenAdmin.dart';

class ServiceDatabase {
  final String uid;

  ServiceDatabase(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference postCollection = 
      FirebaseFirestore.instance.collection("post");

  
  Stream<AppUserData> get user {
    return userCollection.doc(uid).snapshots().map(_userFromSnapshot);
  }
  Stream<DocumentSnapshot> getPost(String docId) => postCollection.doc(docId).snapshots();

  Stream<QuerySnapshot> getCollection() => postCollection.snapshots();

  //Sauvegarde des information de l'utilisateur
  Future<void> saveUser(
      String name, String lastname, String email, String role) async {
    return await userCollection.doc(uid).set({'name': name, 'lastname': lastname, 'email': email, 'role': role},
    );
  }

  Future<QuerySnapshot<Object?>> getProfilePic(File? profilePic) async {
    return await userCollection.where('profileImage', isEqualTo: profilePic).get();
  }

  AppUserData _userFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("post Inconnu");
    return AppUserData(
        uid: uid,
        name: snapshot['name'],
        lastname: snapshot['lastname'],
        email: snapshot['email'],
        role: snapshot['role'],
        profileImage : snapshot['profileImage']);
  }

  //changement de rôle de la part de l'Admin
  Future updateUser(ListRole? role, String docId){
    String test;
    if(role == ListRole.Jeune){
      test="Jeune";
    }else if(role == ListRole.Expert){
      test = "Expert";
    }else if(role == ListRole.Mentor){
      test = "Mentor";
    }else{
      test = "Direction";
    }
    return userCollection.doc(docId)
        .update({'role' : test})
        .then((value) => print('User Updated'))
        .catchError((error) => print("Failed to update user: $error /////" +docId));
  }

//changement de rôle de la part de l'Admin
  /*Future<void> updateRole({
    required String role,
  }) async {
    DocumentReference documentReferencer =
    FirebaseFirestore.instance.collection('users').doc(uid);

    Map<String, dynamic> data = <String, dynamic>{
      "role": role,

    };
    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print("//////$e"));
  }*/

  //Expert créer une fiche conseil
  Future addPost(String title, String type, String description, String useCase, String emailAuthor, String youtubeLink, String community) => postCollection.add({
      'title' : title,
      'type' : type,
      'description' : description,
      'useCase' : useCase,
      'emailAuthor' : emailAuthor,
      'youtube' : youtubeLink,
      'community' : community
    }).then((value) => print("Post Added"))
        .catchError((error) => print("Failed to add post: $error"));

  //Choisir et Sauvegarder la photo de profile dans Firebase Storage
/*Future<void> _uploadImage(String inputSource) async {
  final picker = ImagePicker();
  XFile? pickedImage;

  try {
    pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final String fileName = path.basename(pickedImage!.path);
    File imageFile = File(pickedImage.path);
    try{
      await storage.ref(fileName).putFile(imageFile);
      //setState(() {});
    }on FirebaseException catch(error){
      print(error);
    }
  }catch(err){
    print(err);
  }
}*/


}
