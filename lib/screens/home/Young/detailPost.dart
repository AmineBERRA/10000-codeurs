import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/models/postModel.dart';

class DetailPost extends StatelessWidget {
final PostData postData;
DetailPost(this.postData);

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
        child: Text(postData.description,
          style: GoogleFonts.roboto(),
        ),
      ),
    );
  }
}
