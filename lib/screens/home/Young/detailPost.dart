import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailto/mailto.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/models/postModel.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPost extends StatelessWidget {
final PostData postData;
DetailPost(this.postData);
//static const url = "https://youtube.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: blueCodeurs),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(postData.title,
          style: GoogleFonts.roboto(color: blueCodeurs),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(postData.description,
              style: GoogleFonts.roboto(),
            ),
              Text(postData.useCase,
              style: GoogleFonts.roboto(),
            ),
              TextButton(
                onPressed: _launchEmail,
                child: Text(postData.emailAuthor,
                style: GoogleFonts.roboto(),),
            ),
              TextButton(
                  onPressed: _launchYoutubeLink,
                  child: Text(postData.youtubeLink))
            ],
          ),
        )
      ),
    );
  }

  void _launchYoutubeLink() async =>
      await canLaunch(postData.youtubeLink) ? launch(postData.youtubeLink) : throw 'Could not launch ${postData.youtubeLink}';

  void _launchEmail() async {
    final mailtoLinnk = Mailto(
      to: [postData.emailAuthor],
      subject: '',
      body: '',
    );
    await launch('$mailtoLinnk');
    }
  }


