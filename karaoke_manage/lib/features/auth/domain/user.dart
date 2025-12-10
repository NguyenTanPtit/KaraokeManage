import 'package:json_annotation/json_annotation.dart';


@JsonSerializable()
class AppUser {
  final String id;
  final String fullName;
  final String username;
  final String email;
  final String role;
  final String? phone;

  AppUser({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.role,
    this.phone,
  });

  factory AppUser.fromJson(String uid, Map<String, dynamic> json) {
    return AppUser(
      id: uid,
      username: json['username'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'staff',
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'email': email,
      'role': role,
      'phone': phone,
    };
  }
}
