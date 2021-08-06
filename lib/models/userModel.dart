class AppUser {
  final String? uid;

  AppUser({this.uid});
}

class AppUserData {
  final String uid;
  final String name;
  final String lastname;
  final String email;
  final String role;

  AppUserData(
      {required this.uid,
      required this.name,
      required this.lastname,
      required this.email,
      required this.role});
}

/*class RoleData {
  final String uid;
  final bool admin;
  final bool jeune;
  final bool expert;
  final bool mentor;
  final bool direction;

  RoleData(this.uid, this.admin, this.direction, this.expert, this.jeune,
      this.mentor);
}*/
