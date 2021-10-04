import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/helpers/constants/constantConstant.dart';
import 'package:stage_10000_codeurs/models/postModel.dart';
import 'package:stage_10000_codeurs/widget/dropDownButton.dart';

class EditPost extends StatefulWidget {
  const EditPost({Key? key}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final _key = GlobalKey<FormState>();
  bool loading = false;
  String error = '';
  late String community ;

  final controllerTitle = TextEditingController();
  final controllerType = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerUseCase = TextEditingController();
  final controllerYoutube = TextEditingController();

  @override
  void dispose() {
    controllerTitle.dispose();
    controllerType.dispose();
    controllerDescription.dispose();
    controllerUseCase.dispose();
    controllerYoutube.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _key.currentState?.reset();
      error = '';
      controllerTitle.text = '';
      controllerType.text = '';
      controllerDescription.text = '';
      controllerUseCase.text = '';
      controllerYoutube.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          iconTheme: IconThemeData(color: blueCodeurs),
          backgroundColor: Colors.white,
          title: Text(
            "Retour",
            style: TextStyle(color: blueCodeurs),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(40.0),
            child: Center(
              child: Form(
                key: _key,
                child: Column(
                  children: [
                    //Titre
                    TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      controller: controllerTitle,
                      decoration: InputDecoration(
                        hintText: "Titre",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      validator: (value) => value!.isEmpty
                          ? "Entrer un Titre"
                          : null,
                      cursorHeight: 20.0,
                    ),
                    SizedBox(height:10.0,),
                    //Communauté
                    DropDown(callbackCommu),
                    SizedBox(height:10.0,),
                    //Type
                    TextFormField(
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      controller: controllerType,
                      decoration: InputDecoration(
                        hintText: "Type",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      validator: (value) => value!.isEmpty
                          ? "Entrer un Type"
                          : null,
                      cursorHeight: 20.0,
                    ),
                    SizedBox(height:10.0,),
                    //Description
                    TextFormField(
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      controller: controllerDescription,
                      decoration: InputDecoration(
                        hintText: "Description",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      cursorHeight: 20.0,
                      validator: (value) => value!.isEmpty
                          ? "Entrer une Description"
                          : null,
                    ),
                    SizedBox(height:10.0,),
                    //Use Case
                    TextFormField(
                      maxLines: 10,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      controller: controllerUseCase,
                      decoration: InputDecoration(
                        hintText: "Cas d'utilisation",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      cursorHeight: 20.0,
                      validator: (value) => value!.isEmpty
                          ? "Entrer un Cas d'utilisation"
                          : null,
                    ),
                    SizedBox(height:10.0,),
                    //Youtube Link
                    TextFormField(
                      keyboardType: TextInputType.url,
                      controller: controllerYoutube,
                      decoration: InputDecoration(
                        hintText: "Lien Youtube",
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      cursorHeight: 20.0,
                      validator: (value) => value!.isEmpty
                          ? "Entrer un lien Youtube"
                          : null,
                    ),

                    ElevatedButton.icon(
                        icon: Icon(Icons.add),
                        onPressed: (){
                          validationPost(context);
                        },
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(greenCodeurs)),
                        label: Text("Créer",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ),
            ),

          ),
        ),
      ),
    );
  }

   validationPost(BuildContext context){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Validez",style: GoogleFonts.roboto(),),
            content: Text("Vous allez valider la Fiche de conseils",style: GoogleFonts.roboto(),),
            actions: [
              TextButton.icon(
                onPressed: () async {
                  if (_key.currentState?.validate() == true) {
                    setState(() => loading = true);
                    var title = controllerTitle.value.text;
                    var type = controllerType.value.text;
                    var description = controllerDescription.value.text;
                    var useCase = controllerUseCase.value.text;

                    var auteur = FirebaseAuth.instance.currentUser!.uid;
                    var youtube = controllerYoutube.value.text;

                    var post = PostData(
                        title: title, type: type, description: description,
                        useCase: useCase, author: auteur, youtubeLink: youtube, community: community);
                    databaseService.addPost(post);

                    print("OK : " + title);
                    Navigator.of(context).pop();
                    _snackBar;
                    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                    toggleView();
                  }
                },
                label: Text("Oui",style: GoogleFonts.roboto(),),
                icon: Icon(Icons.done),
              ),
              TextButton.icon(
                label: Text("Non",style: GoogleFonts.roboto(),),
                onPressed: (){
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              )
            ],
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
          );
        }
    );
  }

  final _snackBar = SnackBar(
        content: Text("Félicitation! Vous avez créer une fiche conseils",style: GoogleFonts.roboto(),),
        behavior: SnackBarBehavior.floating,
      );

  void callbackCommu(String newCommunity) {
        community = newCommunity;
}

}

