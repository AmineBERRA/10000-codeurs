class AppUser {
  final String? uid;

  AppUser(this.uid);
}

class AppUserData {
  final String uid;
  final String name;
  final String lastname;
  final String email;
  final String role;
  final String profileImage;

  AppUserData(
      {required this.uid,
      required this.name,
      required this.lastname,
      required this.email,
      required this.role,
      required this.profileImage});
}
