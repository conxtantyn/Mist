class AccountModel {
  final String login;
  final String phone;
  final String firstName;
  final String lastName;
  final String email;
  final String langKey;
  final String password;

  AccountModel({
    required this.login,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.langKey,
    required this.password,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      login: json['login'] as String,
      phone: json['phone'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      langKey: json['langKey'] as String,
      password: json['password'] as String,
    );
  }
}
