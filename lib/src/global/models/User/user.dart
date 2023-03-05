class User {
  final int id;

  // var roleId;
  final String name;
  final String phone;
  final String email;
  final String birthday;
  // final String status;
  User({
    required this.id,
    required this.name,
    // required this.roleId,
    required this.phone,
    required this.email,
    required this.birthday,
  });
  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data["id"],
      name: data["name"],
      // roleId: data["role_id"],
      phone: data["phone"],
      email: data["email"],
      birthday: data["birthday"].toString(),
    );
  }
  factory User.empty() {
    return User(id: -1, name: "", phone: "", email: "", birthday: "");
  }
}
