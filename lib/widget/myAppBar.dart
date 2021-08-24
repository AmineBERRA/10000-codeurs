import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/helpers/constants/imageConstants.dart';
import 'package:stage_10000_codeurs/screens/auth/authentificationScreen.dart';
import 'package:stage_10000_codeurs/services/authentication.dart';

class MyAppBar extends AppBar {

  MyAppBar(BuildContext context) :super(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Image.asset(logo10k,scale: 15,),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              final ServiceAuthentification _auth = ServiceAuthentification();
            await _auth.signOut().whenComplete(() {
                Navigator.push(context,
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                      return AuthenticateScreen();
                    }));
              });
            },
            icon: Icon(
              Icons.logout_outlined,
              color: blueCodeurs,
            ),
          )
        ],
    );
  }

