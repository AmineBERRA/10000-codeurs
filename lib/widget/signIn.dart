import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/helpers/constants/constantConstant.dart';
import 'package:stage_10000_codeurs/helpers/constants/textInputDecoration.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreenAdmin.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreenExpert.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreenManagement.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreenMentor.dart';
import 'package:stage_10000_codeurs/screens/home/homeScreenYoung.dart';
import 'package:stage_10000_codeurs/services/authentication.dart';
import 'loading.dart';

class SignRegister extends StatefulWidget {
  const SignRegister({Key? key}) : super(key: key);

  @override
  _SignRegisterState createState() => _SignRegisterState();
/*@override
  State<StatefulWidget> createState() {
    return _SignRegisterState();
  }*/
}

class _SignRegisterState extends State<SignRegister> {
  final ServiceAuthentification _auth = ServiceAuthentification();
  final CollectionReference roleChoice = FirebaseFirestore.instance.collection('users');

  /*var items = <String>[
    "Jeune",
    "Expert",
    "Direction",
    "Responsable de communauté"
  ];*/
  String roleValue = "Jeune";

  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final controllerEmail = TextEditingController();
  final controllerName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerPassword = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerName.dispose();
    controllerLastName.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      controllerEmail.text = '';
      controllerName.text = '';
      controllerLastName.text = '';
      controllerPassword.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: Text(
                showSignIn ? signIn : register,
                style: TextStyle(color: blueCodeurs),
              ),
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(
                    Icons.person,
                    color: blueCodeurs,
                  ),
                  label: Text(
                    showSignIn ? register : signIn,
                    style: TextStyle(color: blueCodeurs),
                  ),
                  onPressed: () => toggleView(),
                )
              ],
            ),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
                child: Center(
              child: Container(
                color: white,
                padding:
                    EdgeInsets.symmetric(vertical: 150.0, horizontal: 30.0),
                child: Container(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: yellowCodeurs,
                    elevation: 20,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 11.0, horizontal: 30.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            //Box prénom
                            !showSignIn
                                ? TextFormField(
                                    keyboardType: TextInputType.name,
                                    controller: controllerName,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: "Prénom"),
                                    validator: (value) => value!.isEmpty
                                        ? "Enter your name"
                                        : null,
                                  )
                                : Container(),
                            !showSignIn ? SizedBox(height: 10.0) : Container(),

                            //Box Nom de Famille
                            !showSignIn
                                ? TextFormField(
                                    controller: controllerLastName,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: "Nom"),
                                    validator: (value) => value!.isEmpty
                                        ? "Enter your name"
                                        : null,
                                  )
                                : Container(),
                            !showSignIn ? SizedBox(height: 10.0) : Container(),

                            //Box choix de rôles
                            /*!showSignIn ? DropdownButton(
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
                  )
                   : Container(),
                  !showSignIn ? SizedBox(height: 10.0) : Container(),*/

                            //Box email
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: controllerEmail,
                              decoration: textInputDecoration.copyWith(
                                  hintText: "Email"),
                              validator: (value) =>
                                  value!.isEmpty ? "Entrer un email" : null,
                            ),
                            SizedBox(height: 10.0),

                            //Box mot de passe
                            TextFormField(
                              controller: controllerPassword,
                              decoration: textInputDecoration.copyWith(
                                  hintText: "Mot de Passe"),
                              obscureText: true,
                              validator: (value) => value!.length < 6
                                  ? "Entrer un mot de passe de 6 caractère minimum"
                                  : null,
                            ),
                            SizedBox(height: 10.0),

                            //Bouton Connexion/Création de compte
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            greenCodeurs)),
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ==
                                      true) {
                                    setState(() => loading = true);
                                    var password =
                                        controllerPassword.value.text;
                                    var email = controllerEmail.value.text;
                                    var name = controllerName.value.text;
                                    var lastname =
                                        controllerLastName.value.text;

                                    //call firebase auth
                                    dynamic result = showSignIn
                                        ? await _auth.signInEmailPassword(
                                            email, password)
                                        .then((value) {
                                            if (value != null) {
                                              roleChoice.where('email', isEqualTo: email).get().then((userData) {
                                                Navigator.push(context, MaterialPageRoute(
                                                    builder: (BuildContext context){
                                                      if(userData.docs[0]['role'] == 'admin'){
                                                        print("admin" +userData.docs[0]['role']);
                                                        return HomeScreenAdmin();
                                                      }else if(userData.docs[0]['role'] == 'Expert'){
                                                        print("expert" +userData.docs[0]['role']);
                                                        return HomeScreenExpert();
                                                      }else if(userData.docs[0]['role'] == 'Direction'){
                                                        print("direction" +userData.docs[0]['role']);
                                                        return HomeScreenManagement();
                                                      }else if(userData.docs[0]['role'] == 'Mentor'){
                                                        print("mentor" +userData.docs[0]['role']);
                                                        return HomeScreenMentor();
                                                      }else{
                                                        print("jeune" +userData.docs[0]['role']);
                                                        return HomeScreenYoung();
                                                      }
                                                    }
                                                ));
                                              });
                                            }
                                          })
                                        : await _auth.registerEmailPassword(
                                            email,password,name,lastname,roleValue);
                                    print(email);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error =
                                            "Veuillez fournir un email ou un mot de passe valide";
                                      });
                                    }
                                  }
                                },
                                child: Text(showSignIn ? signIn : register)),

                            SizedBox(height: 10.0),
                            Text(
                              error,
                              style: TextStyle(color: redCodeurs),
                            ),
                            TextButton(
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: blueCodeurs)),
                                onPressed: () => toggleView(),
                                child: Text(
                                  showSignIn
                                      ? "Vous n'avez pas de compte \n" +
                                          register
                                      : "Vous avez déjà un compte \n" + signIn,
                                  textAlign: TextAlign.center,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )),
          );
  }
}
