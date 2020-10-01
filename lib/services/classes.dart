class Login {
  final String username;
  final String password;


  Login({this.username, this.password});

  Login.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {
        "username": username,
        "password": password,
      };
}

class Register {
  final String username;
  final String email;
  final String password;
  final String phone;
  final String type;


  Register({this.username, this.password, this.email, this.phone, this.type});

  Register.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        phone = json['phone'],
        type = json['type'],
        password = json['password'];

  Map<String, dynamic> toJson() =>
      {
        "username": username,
        "email": email,
        "password": password,
        "phone": phone,
        "type": type,
      };
}