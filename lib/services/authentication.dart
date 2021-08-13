import 'package:firebase_auth/firebase_auth.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';
import 'package:stage_10000_codeurs/services/database.dart';

class ServiceAuthentification {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<AppUserData?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  AppUserData? _userFromFirebaseUser(User? user) {
    return user != null ? AppUserData(uid: user.uid, name: '', lastname: '', email: '', role: '') : null;
  }

  Future signInEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (exception) {
      print(exception.toString());

    }
  }

  Future registerEmailPassword(String email, String password, String name, String lastName, String role) async {
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      User? user = result.user;
      if(user == null){
        throw Exception("No user");
      }else{
        await ServiceDatabase(user.uid).saveUser(name, lastName, email, role);
        return _userFromFirebaseUser(user);
      }
    }catch(exception){
      print(exception.toString());
      print(email);

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



