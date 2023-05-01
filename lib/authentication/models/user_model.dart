class UserModel {
  final String? email;
  final String phone;
  final String? name;
  final String password;

  const UserModel({
    required this.phone,
    this.email,
    this.name,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {'phone': phone, 'password': password};
  }
}
