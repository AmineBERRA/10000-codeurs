import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';

class DropDown extends StatefulWidget {
  final Function callback;
  //late String drop = "ENTREPREUNARIAT";
  /*var items = <String>[
    "ENTREPRENEURIAT",
    "NO CODE",
    "DEVELOPPEMENT PERSONNEL",
    "CLOUD",
    "SERVICE INFORMATIQUE",
    "GENIE CIVIL",
    "TEST",
    "DATA",
    "INTERNET DES OBJETS",
    "SYSTEME D’INFORMATION",
    "DEVELOPPEMENT D’APPLICATIONS",
    "BRANDING",
    "MARKETING DIGITAL",
    "WOMEN EMPOWERMENT",
    "DIGITAL WORKPLACE",
    "COMMUNITY MANAGEMENT",
    "AGRICULTURE",
    "AGILITE",
    "BLOCKCHAIN",
    "DESIGN",
    "ANGLAIS",
  ];*/
  DropDown(this.callback, {Key? key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  var items = <String>[
    "ENTREPRENEURIAT",
    "NO CODE",
    "DEVELOPPEMENT PERSONNEL",
    "CLOUD",
    "SERVICE INFORMATIQUE",
    "GENIE CIVIL",
    "TEST",
    "DATA",
    "INTERNET DES OBJETS",
    "SYSTEME D’INFORMATION",
    "DEVELOPPEMENT D’APPLICATIONS",
    "BRANDING",
    "MARKETING DIGITAL",
    "WOMEN EMPOWERMENT",
    "DIGITAL WORKPLACE",
    "COMMUNITY MANAGEMENT",
    "AGRICULTURE",
    "AGILITE",
    "BLOCKCHAIN",
    "DESIGN",
    "ANGLAIS",
  ];

   String dropValue = "ENTREPRENEURIAT";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
          value: dropValue,
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: blueCodeurs,
          ),
          style: TextStyle(color: blueCodeurs, fontWeight: FontWeight.bold),
          onChanged: (String? newValue) {
            setState(() {
              dropValue = newValue!;
            });
            widget.callback(newValue);
          },
          items: items.map((String value) {
            return DropdownMenuItem(
              child: Text(value),
              value: value,
            );
          }).toList(),
        );
  }
}
