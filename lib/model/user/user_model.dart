/// Domain user; parsing only — no UI.
class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    this.name,
    this.token,
  });

  final String id;
  final String email;
  final String? name;
  final String? token;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      name: json['name']?.toString(),
      token: json['token']?.toString() ?? json['access_token']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        if (name != null) 'name': name,
        if (token != null) 'token': token,
      };
}
