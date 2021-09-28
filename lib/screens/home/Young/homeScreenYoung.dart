import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/helpers/constants/constantConstant.dart';
import 'package:stage_10000_codeurs/helpers/constants/imageConstants.dart';
import 'package:stage_10000_codeurs/models/postModel.dart';
import 'package:stage_10000_codeurs/screens/auth/authentificationScreen.dart';
import 'package:stage_10000_codeurs/screens/home/Young/detailPost.dart';
import 'package:stage_10000_codeurs/services/authentication.dart';
import 'package:stage_10000_codeurs/widget/loading.dart';
import 'package:stage_10000_codeurs/widget/myAppBar.dart';

class HomeScreenYoung extends StatelessWidget {
  final CollectionReference _post =
      FirebaseFirestore.instance.collection("post");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(context),
      body: StreamBuilder(
        stream: _post.orderBy('community').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }
          return GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (BuildContext context, int index) {
                final PostData postData = PostData(
                    title: snapshot.data.docs[index]['title'],
                    type: snapshot.data.docs[index]['type'],
                    description: snapshot.data.docs[index]['description'],
                    useCase: snapshot.data.docs[index]['useCase'],
                    emailAuthor: snapshot.data.docs[index]['emailAuthor'],
                    youtubeLink: snapshot.data.docs[index]['youtube'],
                    community: snapshot.data.docs[index]['community'],
                );
                return Card(
                  elevation: 5,
                  color: greenCodeurs,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                    child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Text(postData.title,
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                        subtitle: Text(postData.community,
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                        color: Colors.white,),
                        onTap: () => {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return DetailPost(postData);
                              })),
                            }),
                  ),
                );
              });
        },
      ),
    );
  }
}
