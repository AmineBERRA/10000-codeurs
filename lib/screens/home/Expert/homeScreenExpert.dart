import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stage_10000_codeurs/screens/home/Expert/editPost.dart';
import 'package:stage_10000_codeurs/widget/imagePicker.dart';
import 'package:stage_10000_codeurs/widget/loading.dart';
import 'package:stage_10000_codeurs/widget/myAppBar.dart';

class HomeScreenExpert extends StatelessWidget {
  final String docId;

  HomeScreenExpert({required this.docId});

  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var userDetail = FirebaseFirestore.instance.collection("users");
    //var post = FirebaseFirestore.instance.collection("post");
    return Scaffold(
        appBar: MyAppBar(context),
        body: Center(
          child: new StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users').doc(
                  currentUser!.uid.toString()).snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Loading();
                }
                var data = snapshot.data!.data() as Map<String, dynamic>;
                print(data);
                return Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        ImageFromGallery(data),
                        SizedBox(height: 20.0),
                        Text("Prénom:${data['name']}",
                          style: GoogleFonts.roboto(),),
                        SizedBox(height: 20.0),
                        Text("Nom de famille:${data['lastname']}",
                          style: GoogleFonts.roboto(),),
                        SizedBox(height: 20.0),
                        Text("Email:${data['email']}",
                          style: GoogleFonts.roboto(),),
                        SizedBox(height: 100.0),
                        ElevatedButton.icon(
                          label: Text("Editer une Fiche",
                              style: GoogleFonts.roboto(fontSize: 20)),
                          icon: Icon(Icons.post_add_outlined),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(double.infinity, 70)),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return EditPost();
                                }));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ));
  }
}
