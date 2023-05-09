class RegisterModel {
  String? phone, name;

  RegisterModel({this.phone, this.name});

  Map<String, dynamic> toJson() => {'phone': phone, 'name': name};
}
