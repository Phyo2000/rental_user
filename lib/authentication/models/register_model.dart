class RegisterModel {
  String? phone, name;

  RegisterModel({this.phone, this.name});

  Map<String, dynamic> toJson() => {'phoneNumber': phone, 'name': name};
}
