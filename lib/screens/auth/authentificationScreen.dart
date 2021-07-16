import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/widget/background.dart';
import 'package:stage_10000_codeurs/widget/signIn.dart';

class AuthenticateScreen extends StatelessWidget {
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignRegister(),
    );
  }
}
