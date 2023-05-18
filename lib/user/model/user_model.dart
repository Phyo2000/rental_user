import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String name;
  final String username;
  final String phone;
  final String token;

  UserModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.phone,
      required this.token});
}

class ModelUser with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  void setUser({
    required String id,
    required String name,
    required String username,
    required String phone,
    required String token,
  }) {
    _user = UserModel(
      id: id,
      name: name,
      username: username,
      phone: phone,
      token: token,
    );
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {'user_id': _user.id};
}
