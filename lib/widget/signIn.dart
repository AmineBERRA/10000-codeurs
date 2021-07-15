import 'package:flutter/material.dart';
import 'loading.dart';

class SignRegister extends StatefulWidget {
  const SignRegister({Key? key}) : super(key: key);

  @override
  _SignRegisterState createState() => _SignRegisterState();
}

class _SignRegisterState extends State<SignRegister> {
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
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              children: [
                TextFormField(
                  controller: controllerEmail,
                  decoration: text,
                  validator: (value) => value!.isEmpty ? "Enter an email" : null,
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: controllerPassword,
                  obscureText: true,
                  validator: (value) => value!.length < 6 ? "Enter a password" : null,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

