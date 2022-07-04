class Account {
  final int id;
  final String login;
  final String phone;
  final String firstName;
  final String lastName;
  final String email;
  final bool activated;
  final String langKey;
  final List<dynamic> authorities;

  Account({
    required this.id,
    required this.login,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.activated,
    required this.langKey,
    required this.authorities,
  });

  Account.guest()
      : this.id = 0,
        this.login = '',
        this.phone = '',
        this.firstName = '',
        this.lastName = '',
        this.email = '',
        this.activated = false,
        this.langKey = '',
        this.authorities = [];

  Account copyWith({
    int? id,
    String? login,
    String? phone,
    String? firstName,
    String? lastName,
    String? email,
    bool? activated,
    String? langKey,
    List<dynamic>? authorities,
  }) =>
      Account(
        id: id ?? this.id,
        login: login ?? this.login,
        phone: phone ?? this.phone,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        activated: activated ?? this.activated,
        langKey: langKey ?? this.langKey,
        authorities: authorities ?? this.authorities,
      );

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as int,
      login: json['login'] as String,
      phone: json['phone'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      activated: json['activated'] as bool,
      langKey: json['langKey'] as String,
      authorities: List<String>.from(json['authorities']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'login': login,
      'phone': phone,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'activated': activated,
      'langKey': langKey,
      'authorities': authorities,
    };
  }
}
