class UserModel {
  final String id;
  final String name;
  final String email;
  final String? token;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.token,
  });

  UserModel copyWith({String? id, String? name, String? email, String? token}) {
    return UserModel(
      id: id ?? this.id,
      token: token ?? this.token,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
    );
  }

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, email: $email, token: $token)';
}
