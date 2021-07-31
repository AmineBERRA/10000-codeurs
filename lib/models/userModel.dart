class AppUser{
  final String? uid;

  AppUser({required this.uid});
}

class AppUserData {
  final String uid;
  final String name;
  final String lastname;
  final String dropDownRole;
  final String email;

  AppUserData({required this.uid, required this.name, required this.lastname, required this.dropDownRole, required this.email});
}
