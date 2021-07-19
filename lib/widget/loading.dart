import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: SpinKitPulse(
            color: blueCodeurs,
            size: 80.0,
      )),
    );
  }
}
