import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';
import 'package:stage_10000_codeurs/screens/auth/authentificationScreen.dart';
import 'package:stage_10000_codeurs/screens/splashScreenWrapper.dart';
import 'package:stage_10000_codeurs/services/authentication.dart';
import 'package:stage_10000_codeurs/widget/background.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: ServiceAuthentification().user,
      initialData: null,
      child:MaterialApp(
        debugShowCheckedModeBanner : false,
        home: Container(
          child: Stack(
            children: [
              SplashScreenWrapper(),
              Background()
            ],
          ),
        )
      ),
    );

  }
}

