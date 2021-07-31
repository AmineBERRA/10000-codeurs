import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    //borderRadius: BorderRadius.circular(30.0),
    borderSide: BorderSide(color: Colors.blueGrey, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 1.0),
    //borderRadius: BorderRadius.all(30.0)
  ),
);