import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';
import 'package:stage_10000_codeurs/screens/auth/authentificationScreen.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreen.dart';

class SplashScreenWrapper extends StatelessWidget {
  const SplashScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if(user == null){
      return AuthenticateScreen();
    }else{
      return HomeScreen();
    }
  }
}
