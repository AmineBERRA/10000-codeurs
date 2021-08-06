import 'package:firebase_auth/firebase_auth.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';
import 'package:stage_10000_codeurs/services/database.dart';

import 'authException.dart';

class ServiceAuthentification {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

/*  Future<Map<String, dynamic>?> get claims async {
    final user = _auth.currentUser;
    final token = await user!.getIdTokenResult(true);
    return (token.claims);
  }*/

  Future signInEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

 /* Future registerEmailPassword(String name, String lastname, String role, String email,String password) async{
    try{
      UserCredential result =
      await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      User? user = result.user;

      await ServiceDatabase(user!.uid).saveUser(name, lastname, email, role);
      return _userFromFirebaseUser(user);
    }on FirebaseAuthException catch(exception){
      print(exception.code);
      print(exception.message);
      return null;
    }
  }*/
  Future registerEmailPassword(String email, String password, String name, String lastName, String role) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      User? user = result.user;
      await ServiceDatabase(user!.uid).saveUser(name, lastName, email, role);
      return _userFromFirebaseUser(user);
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }

 /* Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }*/

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
    print(exception.toString());
    return null;
    }
  }
}



