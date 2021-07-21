import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/services/authentication.dart';

class HomeScreenYoung extends StatelessWidget {
  final ServiceAuthentification _auth = ServiceAuthentification();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Welcome",
          style: TextStyle(color: blueCodeurs),),
          actions: <Widget>[
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: blueCodeurs,
                ),
                label: Text(
                  "Logout",
                  style: TextStyle(color: blueCodeurs),
                ))
          ],
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            child: Text(
              "Bienvenue sur l'application 10 000 codeurs"
                  "Section Jeune",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          )

        ));
  }
}
