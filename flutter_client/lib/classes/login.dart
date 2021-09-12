import './common.dart';

class LoginResponse{
  final Status status;
  final String name;
  final String email;

  LoginResponse({this.status, this.name, this.email});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: Status.fromJson(json['status']),
      email: json['email'],
      name: json['name'],
    );
  }
}