import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stage_10000_codeurs/screens/home/Expert/editPost.dart';
import 'package:stage_10000_codeurs/widget/imagePicker.dart';
import 'package:stage_10000_codeurs/widget/loading.dart';
import 'package:stage_10000_codeurs/widget/myAppBar.dart';

class HomeScreenExpert extends StatelessWidget {
  final String docId;

  HomeScreenExpert({required this.docId});


  @override
  Widget build(BuildContext context) {
    var userDetail = FirebaseFirestore.instance.collection("users");
    //var post = FirebaseFirestore.instance.collection("post");
    return Scaffold(
        appBar: MyAppBar(context),
        body: Center(
          child: FutureBuilder<DocumentSnapshot>(
            future: userDetail.doc(docId).get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Quelque chose a mal tourné");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Le document n'existe pas");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return Container(
                  //alignment: Alignment.center,
                  //margin: EdgeInsets.symmetric(vertical: 120.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        ImageFromGallery(),
                        SizedBox(height: 20.0),
                        Text("Prénom : ${data['name']}",style: GoogleFonts.roboto(),),
                        SizedBox(height: 20.0),
                        Text("Nom de famille : ${data['lastname']}",style: GoogleFonts.roboto(),),
                        SizedBox(height: 20.0),
                        Text("Email : ${data['email']}",style: GoogleFonts.roboto(),),
                       /* SizedBox(height: 20.0),
                        Text("Communauté : ${data['community']}",style: GoogleFonts.roboto(),),*/
                        SizedBox(height: 100.0),
                        ElevatedButton.icon(
                          label: Text("Editer une Fiche",style: GoogleFonts.roboto(fontSize: 20)),
                          icon: Icon(Icons.post_add_outlined),
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(double.infinity, 70)),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                              return EditPost();
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Loading();
            },
          ),
        ));
  }
}
