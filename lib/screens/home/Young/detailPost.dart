import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailto/mailto.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/models/postModel.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPost extends StatefulWidget {
final PostData postData;
DetailPost(this.postData);

  @override
  _DetailPostState createState() => _DetailPostState();
}

class _DetailPostState extends State<DetailPost> {
final CollectionReference userinfo =
FirebaseFirestore.instance.collection("users");

var profileImage = FirebaseFirestore.instance.collection('users').doc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blueCodeurs),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.postData.title,
          style: GoogleFonts.roboto(color: blueCodeurs, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
            child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                        elevation: 5,
                        color: blueCodeurs,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Description : \n\n" + widget.postData.description,
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),)
                      ),
                      SizedBox(height: 20.0),
                      Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text("Cas d'utilisation : \n\n" + widget.postData.useCase +"\n\n"+ profileImage.toString(),
                            style: GoogleFonts.roboto(),
                          ),
                        )
                      ),
                      SizedBox(height: 20.0),
                      TextButton(
                        onPressed: _launchEmail,
                        child: Text("Email de l'Expert : " + widget.postData.emailAuthor,
                          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),),
                      ),
                      CircleAvatar(radius: 30,),
                      SizedBox(height: 20.0),
                      Image.network(profileImage.toString()),
                      SizedBox(height: 20.0),
                      TextButton(
                          onPressed: _launchYoutubeLink,
                          child: Text("Lien Youtube du Webinaire : " + widget.postData.youtubeLink,
                            style: GoogleFonts.roboto(fontWeight: FontWeight.bold),)
                      )
                    ],
                  ),
                )
            ),
          ),
      );
  }

  void _launchYoutubeLink() async =>
      await canLaunch(widget.postData.youtubeLink) ? launch(widget.postData.youtubeLink) : throw 'Could not launch ${widget.postData.youtubeLink}';

  void _launchEmail() async {
    final mailtoLink = Mailto(
      to: [widget.postData.emailAuthor],
      subject: '',
      body: '',
    );
    await launch('$mailtoLink');
    }
}


