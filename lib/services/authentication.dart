import 'package:firebase_auth/firebase_auth.dart';
import 'package:stage_10000_codeurs/models/userModel.dart';
import 'package:stage_10000_codeurs/services/database.dart';

class ServiceAuthentification {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future<Map<String,dynamic>?> get claims async{
    final user = _auth.currentUser;
    final token = await user!.getIdTokenResult(true);
    return (token.claims);
  }

  Future signInEmailPassword(String email,String password) async{
    try{
      UserCredential result =
        await _auth.signInWithEmailAndPassword(email: email, password: password);
          User? user = result.user;
      return _userFromFirebaseUser(user!);
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }

  Future registerEmailPassword(String name, String lastname, String dropDownRole,String email,String password) async{
    try{
      UserCredential result =
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      await ServiceDatabase(user!.uid).savaUser(name, lastname, dropDownRole, email);
      return _userFromFirebaseUser(user);
    }catch(exception){
      print(exception.toString());
      return null;
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(exception){
    print(exception.toString());
    return null;
    }
  }
}