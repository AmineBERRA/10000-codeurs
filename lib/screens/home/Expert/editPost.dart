import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/helpers/constants/constantConstant.dart';

class EditPost extends StatefulWidget {
  const EditPost({Key? key}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  final _key = GlobalKey<FormState>();
  bool loading = false;
  String error = '';

  final controllerTitle = TextEditingController();
  final controllerType = TextEditingController();
  final controllerDescription = TextEditingController();
  final controllerUseCase = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose() {
    controllerTitle.dispose();
    controllerType.dispose();
    controllerDescription.dispose();
    controllerUseCase.dispose();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  ElevatedButton.icon(
                    icon: Icon(Icons.add),
                    onPressed: (){
                      _showDialog(context);
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(greenCodeurs)),
                    label: Text(
                      "Créer",
                      style: TextStyle(color: Colors.white),
                  ))
                ],
              ),
            ),
          ),

          /*child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  TextField(
                    controller: controllerTitle,
                    decoration: textInputDecoration.copyWith(hintText: "Titre"),
                  ),
                  TextField(
                    controller: controllerTitle,
                    decoration: textInputDecoration.copyWith(hintText: "Type"),
                  ),
                ],
              ),
              TextField(
                controller: controllerDescription,
                decoration: textInputDecoration.copyWith(hintText: "Description"),
              ),
              TextField(
                controller: controllerUseCase,
                decoration: textInputDecoration.copyWith(hintText: "Cas d'Utilisation"),
              ),
              ElevatedButton(
                onPressed:()async{
                  if(_key.currentState?.validate()==true){
                    setState(()=>loading=true);
                    var title=controllerTitle.value.text;
                    var type=controllerType.value.text;
                    var description=controllerDescription.value.text;
                    var useCase=controllerUseCase.value.text;
                    bookingService.addPost(title,type,description,useCase);
                    print("OK:"+title);
                  }
                },
                child:Text(
                  "Créer",
                  style:TextStyle(color:Colors.white),
                ),
                style:ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(greenCodeurs)),
              )
            ],
          ),
        ),*/
        ),
      ),
    );
  }

   _showDialog(BuildContext context){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Validez"),
            content: Text("Vous allez valider la Fiche de conseils"),
            actions: [
              TextButton.icon(
                onPressed: () async {
                  if (_key.currentState?.validate() == true) {
                    setState(() => loading = true);
                    var title = controllerTitle.value.text;
                    var type = controllerType.value.text;
                    var description = controllerDescription.value.text;
                    var useCase = controllerUseCase.value.text;
                    bookingService.addPost(
                        title, type, description, useCase);
                    print("OK : " + title);
                    Navigator.of(context).pop();
                    _snackBar();
                    toggleView();
                  }
                },
                label: Text("Oui"),
                icon: Icon(Icons.done),
              ),
              TextButton.icon(
                label: Text("Non"),
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

  _snackBar() {
    return Scaffold(
      body: SnackBar(
        content: Text("Félicitation! Vous avez créer une fiche conseils"),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

