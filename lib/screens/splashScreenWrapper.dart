import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';
import 'package:stage_10000_codeurs/screens/auth/authentificationScreen.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreenCommunity.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreenExpert.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreenManagement.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreenYoung.dart';

/*
class SplashScreenWrapper extends StatelessWidget {


  @override
  Future<Widget> build(BuildContext context)   async {


  }
}
*/

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
  CollectionReference choiceRole = FirebaseFirestore.instance.collection('users');

    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return AuthenticateScreen();
    } else {/*
      if (user == choiceRole.where('role', isEqualTo: 'Jeune')) {
        return HomeScreenYoung();
      } else {
        if (user == choiceRole.where('role', isEqualTo: 'Direction')) {
          return HomeScreenManagement();
        } else {
          if (user == choiceRole.where('role', isEqualTo: 'Responsable de Communauté')) {
            return HomeScreenCommunity();
          } else {
            if (user == choiceRole.where('role', isEqualTo: 'Expert')) {
              return HomeScreenExpert();
            }
          }
        }
      }*/
      return HomeScreenYoung();
      /*switch (user) {
        case FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'Jeune') :
          {
            return HomeScreenYoung();
          }

        case choiceRole.where('role', isEqualTo: 'Responsable de communauté'):
          {
            return HomeScreenCommunity();
          }

        case choiceRole.where('role', isEqualTo: 'Direction'):
          {
            return HomeScreenManagement();
          }

        case choiceRole.where('role', isEqualTo: 'Expert'):
          {
            return HomeScreenExpert();
          }
      }*/
    }
  }
}
