import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/imageConstants.dart';
import 'package:stage_10000_codeurs/services/authentication.dart';

class HomeScreen extends StatelessWidget {
  final ServiceAuthentification _auth = ServiceAuthentification();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Welcome"),
          actions: <Widget>[
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
                label: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Center(
          child: Text(
            "Bienvenue sur l'application 10 000 codeurs",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
