import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/screens/auth/authentificationScreen.dart';
import 'package:stage_10000_codeurs/services/authentication.dart';
import 'package:stage_10000_codeurs/widget/myAppBar.dart';

class HomeScreenMentor extends StatelessWidget {
  final ServiceAuthentification _auth = ServiceAuthentification();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(context),
        body: Center(
            child: Container(
              color: Colors.white,
              child: Text(
                "Bienvenue sur l'application 10 000 codeurs \n"
                    "Section Mentor",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            )

        ));
  }
}