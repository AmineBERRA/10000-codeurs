import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/imageConstants.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Opacity(
          opacity: 0.2,
          child: Image.asset(logo10k, scale: 3,),
        ),
      ),
    );
  }
}
