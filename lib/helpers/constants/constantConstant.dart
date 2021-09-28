import 'package:stage_10000_codeurs/services/database.dart';

const register = "S'Enregistrer";
const signIn = "Se Connecter";
const logOut = "Deconnexion";

final ServiceDatabase databaseService = ServiceDatabase("post");
final ServiceDatabase userService = ServiceDatabase("users");

//final Analytics _analytics = Analytics();