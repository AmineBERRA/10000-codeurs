import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageFromGallery extends StatefulWidget {
  /*final type;
  ImageFromGallery(this.type);*/

  @override
  _ImageFromGalleryState createState() => _ImageFromGalleryState();
}

class _ImageFromGalleryState extends State<ImageFromGallery> {
  var _image;
  var imagePicker;
  late String imageUrl;

  @override
  void initState() {
    super.initState();
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.grey,
      child: GestureDetector(
        onTap: () async {
          var source = ImageSource.gallery;
          XFile image = await imagePicker.pickImage(source: source);
          setState(() {
            _image = File(image.path);
            print(_image);
          });
          //uploadImage();
        },
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 100,
              child: _image != null ? Image.file(
                _image,
                fit: BoxFit.contain,)
                  : CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.photo_camera,
                        color: Colors.white),
                  )
        ),
      ),
    );
  }

  /*uploadImage() async {
    final _firebaseStorage = FirebaseStorage.instance;
    final _imagePicker = ImagePicker();
    XFile image;

    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;

    if(permissionStatus.isGranted){
      image = (await  _imagePicker.pickImage(source: ImageSource.gallery))! ;
      var file = File(image.path);
      if(image != null){
        var snapshot = await _firebaseStorage.ref()
        .child('image/profile picture')
        .putFile(file).whenComplete((){});
        var downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imageUrl = downloadUrl;
          print("/////////");
          print(imageUrl);
        });

      }else {
        print('No Image Path Received');
      }
    }else {
      print('Permission not granted. Try Again with permission access');
    }
  }*/
}
