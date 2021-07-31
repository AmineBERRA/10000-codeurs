import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';
import 'package:stage_10000_codeurs/screens/auth/authentificationScreen.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreenYoung.dart';

import 'home/homeScreenCommunity.dart';
import 'home/homeScreenExpert.dart';
import 'home/homeScreenManagement.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
   final CollectionReference choiceRole =
        FirebaseFirestore.instance.collection('users');

    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return AuthenticateScreen();
    } else {
      if (user == choiceRole.where('role', isEqualTo: 'Jeune').snapshots()) {
        print("Jeune");
        return HomeScreenYoung();
      } else {
        if (user == choiceRole.where('role', isEqualTo: 'Direction').snapshots()) {
          print("Direction");
          return HomeScreenManagement();
        } else {
          if (user == choiceRole.where('role', isEqualTo: 'Responsable de Communauté').snapshots()) {
            print("Responsable");
            return HomeScreenCommunity();
          } else {
            if (user == choiceRole.where('role', isEqualTo: 'Expert').snapshots()) {
              print("Expert");
              return HomeScreenExpert();
            }
          }
        }
      }

      print("Failed");
      return HomeScreenYoung();
      /*  return Scaffold(
        body: Center(
          child: Text("Fail"),
        ),
      );*/
     /* switch (user != null) {

        case choiceRole.where('role', isEqualTo: 'Responsable de communauté'):
          {
            print("Responsable de communauté");
            return HomeScreenCommunity();
          }
          break;

        case choiceRole.where('role', isEqualTo: 'Direction'):
          {
            print("Direction");
            return HomeScreenManagement();
          }
          break;

        case choiceRole.where('role', isEqualTo: 'Expert'):
          {
            print("Expert");
            return HomeScreenExpert();
          }
          break;

        default: {
          print("Jeune");
        return HomeScreenYoung();
          }
          break;
      }*/

    }
  }
}
