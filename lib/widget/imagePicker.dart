import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';

class ImageFromGallery extends StatefulWidget {
  final Map<String, dynamic> data;

  ImageFromGallery(this.data);

  @override
  _ImageFromGalleryState createState() => _ImageFromGalleryState();
}

class _ImageFromGalleryState extends State<ImageFromGallery> {
  File? _file;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Column(children: <Widget>[
        Row(
          children: [
            widget.data["profileImage"]
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.data["profileImage"],
                      height: 150.0,
                      width: 100.0,
                    ),
                  )
                : Icon(
                    Icons.person,
                    size: 60,
                  ),

            /* currentUser == null ?
              Icon(Icons.person,
                size: 60,)
                  :  Image.file(_file!,
                fit: BoxFit.contain,
                height: 200,
                width: 200,)*/
            ElevatedButton(
              onPressed: () {
                chooseImage();
                validationProfileImage(context);
                //updateProfile(context);
              },
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white,
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                primary: blueCodeurs,
                onPrimary: greenCodeurs,
              ),
            )
          ],
        ),
      ])

          /*GestureDetector(
          onTap: () async {
            chooseImage();
            updateProfile(context);
          },
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 100,
                child: _file != null ? Image.file(
                  _file,
                  fit: BoxFit.contain,)
                    : CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.grey,
                      child: Icon(Icons.photo_camera,
                          color: Colors.white),
                    )
          ),
        ),*/
          ),
    );
  }

  chooseImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _file = File(image!.path);
      print(_file);
    });
  }

  Future<String> uploadImage() async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("profilePicture")
        .child(FirebaseAuth.instance.currentUser!.email! +
            "_" +
            basename(_file!.path))
        .putFile(_file!);
    return taskSnapshot.ref.getDownloadURL();
  }

  updateProfile(BuildContext context) async {
    Map<String, dynamic> map = Map();
    if (_file != null) {
      String url = await uploadImage();
      map['profileImage'] = url;
      print(url);
      print(_file);
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(map);
    Navigator.pop(context);
  }

  validationProfileImage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Photo de Profile"),
            content: Text("Validez la photo ?"),
            actions: [
              TextButton.icon(
                  onPressed: () {
                    updateProfile(context);
                    Navigator.of(context).pop();
                    //print(profileImage);
                  },
                  icon: Icon(
                    Icons.done,
                    color: blueCodeurs,
                  ),
                  label: Text("Valider")),
              TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: redCodeurs,
                  ),
                  label: Text("Annuler"))
            ],
          );
        });
  }
}
