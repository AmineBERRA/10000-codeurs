import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/constants/imageConstants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner : false,
      home: Scaffold(
        body: Center(
          child:Opacity(
            opacity: 0.5,
            child:Image.asset(logo10k,scale: 3,),
          )

        )
      ),
    );
  }
}

