import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageRepo{
  final uid;
  StorageRepo(this.uid);
  FirebaseStorage storage = FirebaseStorage.instance;
  CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<String> uploadImage(File file) async {
    var userId = userCollection.doc(uid);
    var storageRef = storage.ref().child('user/profile/$userId');
    var uploadTask = storageRef.putFile(file);
    var completeTask = await uploadTask.whenComplete(()=>{});
    String downloadUrl = await completeTask.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return storage.ref().child('user/profile/$uid').getDownloadURL();
  }
}