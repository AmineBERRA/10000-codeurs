import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stage_10000_codeurs/models/postModel.dart';
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


  //Expert créer une fiche conseil
  Future addPost(PostData post) => postCollection.add({
      'title' : post.title,
      'type' : post.type,
      'description' : post.description,
      'useCase' : post.useCase,
      'author' : post.author,
      'youtube' : post.youtubeLink,
      'community' : post.community
    }).then((value) => print("Post Added"))
        .catchError((error) => print("Failed to add post: $error"));


  Future<QuerySnapshot<Object?>> getProfilePic(File? profilePic) async {
    return await userCollection.where('profileImage', isEqualTo: profilePic).get();
  }

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
