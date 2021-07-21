import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';

class DropDownButton extends StatefulWidget {
  const DropDownButton({Key? key}) : super(key: key);

  @override
  _DropDownButtonState createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  var items = <String>[
    "Jeune",
    "Expert",
    "Direction",
    "Responsable de communauté"
  ];
  String dropValue = "Jeune";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
          value: dropValue,
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: blueCodeurs,
          ),
          style: TextStyle(color: blueCodeurs),
          onChanged: (String? newValue) {
            setState(() {
              dropValue = newValue!;
            });
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
