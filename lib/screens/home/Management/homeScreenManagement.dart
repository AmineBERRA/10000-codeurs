import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/services/authentication.dart';
import 'package:stage_10000_codeurs/widget/myAppBar.dart';

class HomeScreenManagement extends StatelessWidget {
  final ServiceAuthentification _auth = ServiceAuthentification();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(context),
        body: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        "Bienvenue sur l'application 10 000 codeurs\n"
                            "Section Direction",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ),
                Divider(thickness: 2,),
                Expanded(
                  child:Center(
                    child: Container(
                      color: redCodeurs,
                      child: Text("Emplacement Statistiques",
                        style: GoogleFonts.roboto(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            )
    );
  }
}