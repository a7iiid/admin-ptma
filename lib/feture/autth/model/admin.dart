class Admin {
  String name;
  String email;
  String password;
  int phone;
  int level;
  Admin(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone,
      required this.level});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
        name: json['name'],
        email: json['email'],
        password: json['passowrd'],
        level: json['level'],
        phone: json['phone']);
  }
}
