import 'package:flutter/material.dart';
import 'package:stage_10000_codeurs/helpers/constants/colorsConstant.dart';
import 'package:stage_10000_codeurs/helpers/constants/textInputDecoration.dart';
import 'package:stage_10000_codeurs/services/authentication.dart';
import 'loading.dart';

class SignRegister extends StatefulWidget {
  const SignRegister({Key? key}) : super(key: key);

  @override
  _SignRegisterState createState() => _SignRegisterState();
}

class _SignRegisterState extends State<SignRegister> {

  final ServiceAuthentification _auth = ServiceAuthentification();

  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  bool showSignIn = true;

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }
  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      controllerEmail.text = '';
      controllerPassword.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :
    Scaffold(
     //backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0.0,
        title: Text(showSignIn ? "Sign In" : "Register"),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person,color: Colors.white,),
            label: Text(showSignIn ? "Register" : "Sign In",
              style: TextStyle(color: Colors.white),),
            onPressed: () => toggleView(),
          )
        ],
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  TextFormField(
                    controller: controllerEmail,
                    decoration: textInputDecoration.copyWith(hintText: "Email"),
                    validator: (value) => value!.isEmpty ? "Enter an email" : null,
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: controllerPassword,
                    decoration: textInputDecoration.copyWith(hintText: "Password"),
                    obscureText: true,
                    validator: (value) => value!.length < 6 ? "Enter a password with 6 character minimum" : null,
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(blueCodeurs)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()){
                          setState(() => loading = true);
                          var password  = controllerPassword.value.text;
                          var email = controllerEmail.value.text;

                          //TODO call firebase auth
                          dynamic result = showSignIn
                              ? await _auth.signInEmailPassword(email, password)
                              : await _auth.registerEmailPassword(email, password);
                          if(result == null){
                            setState(() {
                              loading = false;
                              error = "Please supply a valid email";
                            });
                          }
                        }
                      },
                      child: Text(showSignIn ? "Sign In" : "Register")
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}

