import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './login_screen.dart';

class Status{
  final bool success;
  final String errorMessage;

  Status({this.success, this.errorMessage});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      success: json['success'],
      errorMessage: json['error_message']
    );
  }
}

Future<Status> registerCall(String name, String email, String password, String confirmPassword) async{
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8080/register'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin':"*",
    },
    body: jsonEncode(<String, String>{
      'name': name,
      'email':email,
      'password':password,
      'confirm_password':confirmPassword,
    }),
  );

  if (response.statusCode != 200) {
    print('Failed to create user. \n StatusCode: ${response.statusCode}');  
  }
  
  return Status.fromJson(jsonDecode(response.body)['status']);
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('REGISTER'),
        ),
      body: Column(
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(hintText: 'Enter Name'),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: 'Enter Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(hintText: 'Enter Password'),
          ),
          TextField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(hintText: 'Confirm Password'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                registerCall(_nameController.text, _emailController.text, _passwordController.text, _confirmPasswordController.text).then((Status _status){
                  if (_status.success == false){
                    print('errorMessage: ${_status.errorMessage}');
                    return Text(_status.errorMessage);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                });
              });
            },
            child: const Text('Register'),
          ),
        ],
      ),
     ),
    );
  }
}