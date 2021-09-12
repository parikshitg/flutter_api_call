import './common.dart';

class User{
  final String name;
  final String email;

  User({this.name, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      name: json['name'],
    );
  }
}

class ListResponse{
  final Status status;
  final List<User> users;

  ListResponse({this.status, this.users});

  factory ListResponse.fromJson(Map<String, dynamic> json) {
    return ListResponse(
      status: Status.fromJson(json['status']),
      users: ((json['users']) as List).map((i) => User.fromJson(i)).toList(),
    );
  }
}