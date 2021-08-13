import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';
import 'package:stage_10000_codeurs/screens/auth/authentificationScreen.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreenYoung.dart';

import 'home/homeScreenAdmin.dart';
import 'home/homeScreenExpert.dart';
import 'home/homeScreenManagement.dart';
import 'home/homeScreenMentor.dart';

class SplashScreenWrapper extends StatelessWidget {
  //final CollectionReference roleChoice = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUserData?>(context);
    if (user == null) {
      return AuthenticateScreen();
    } else {
      print("USER OK");
      print("role de l'user : "+user.role);
      print("email : "+user.email);
      print("nom : "+user.lastname);
      print("uid : "+user.uid);
      print("//////////////////////////");
      if (user.role == 'Mentor') {
        print("vous êtes dans la page mentor");
        return HomeScreenMentor();
      } else if (user.role == 'admin') {
        print("vous êtes dans la page admin");
        return HomeScreenAdmin();
      } else if (user.role == 'Direction') {
        print("vous êtes dans la page direction");
        return HomeScreenManagement();
      } else if (user.role == 'Expert') {
        print("vous êtes dans la page expert");
        return HomeScreenExpert();
      } else {
        print("vous êtes dans la page jeune");
        return HomeScreenYoung();
      }

    }
  }
}
//return HomeScreenYoung();
