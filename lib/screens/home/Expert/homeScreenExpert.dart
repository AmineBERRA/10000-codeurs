import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/screens/auth/authentificationScreen.dart';
import 'package:stage_10000_codeurs/screens/home/Expert/editPost.dart';
import 'package:stage_10000_codeurs/services/authentication.dart';
import 'package:stage_10000_codeurs/widget/loading.dart';
import 'package:stage_10000_codeurs/widget/myAppBar.dart';

class HomeScreenExpert extends StatelessWidget {
  final String docId;

  HomeScreenExpert({required this.docId});

  final ServiceAuthentification _auth = ServiceAuthentification();

  @override
  Widget build(BuildContext context) {
    var userDetail = FirebaseFirestore.instance.collection("users");
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
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 120.0),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text("Prénom : ${data['name']}"),
                        SizedBox(height: 50.0),
                        Text("Nom de famille : ${data['lastname']}"),
                        SizedBox(height: 50.0),
                        Text("Email : ${data['email']}"),
                        SizedBox(height: 100.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) {
                              return EditPost();
                            }));
                          },
                          child: Text("Editer une Fiche"),
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
