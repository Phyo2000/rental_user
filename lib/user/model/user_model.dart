import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String name;
  final String username;
  final String phone;
  final String token;
  String? profile;

  UserModel(
      {required this.id,
      required this.name,
      required this.username,
      required this.phone,
      required this.token,
      this.profile});
}

class ModelUser with ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  String get name => _user.name;

  String get phone => _user.phone;

  void setUser({
    required String id,
    required String name,
    required String username,
    required String phone,
    required String token,
    String? profile,
  }) {
    _user = UserModel(
        id: id,
        name: name,
        username: username,
        phone: phone,
        token: token,
        profile: profile);
    notifyListeners();
  }

  Map<String, dynamic> toJson() => {'user_id': _user.id};
}
