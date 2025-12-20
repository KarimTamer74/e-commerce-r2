// models/user_info_model.dart
class UserInfoModel {
  final String email, password, firstName, lastName;

  UserInfoModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName,
    };
  }
}
