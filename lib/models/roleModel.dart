class Role {
  int roleID;
  String role;

  Role({required this.roleID, required this.role});

  static List<Role> getUsers() {
    return <Role>[
      Role(roleID: 1, role: "Jeune"),
      Role(roleID: 2, role: "Expert"),
      Role(roleID: 3, role: "Mentor"),
      Role(roleID: 4, role: "Direction"),
    ];
  }
}