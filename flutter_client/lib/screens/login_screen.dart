import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './home_screen.dart';
import '../classes/login.dart';
import '../config/config.dart';


Future<LoginResponse> loginCall(String email, password) async{
  final response = await http.post(
    Uri.parse('$BASE_URL/login'),
    headers: headers,
    body: jsonEncode(<String, String>{
      'email':email,
      'password':password,
    }),
  );

  if (response.statusCode != 200) {
    print('Failed to create user. \n StatusCode: ${response.statusCode}');  
  }
  
  return LoginResponse.fromJson(jsonDecode(response.body));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('LOGIN'),
        ),
      body: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: 'Enter Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(hintText: 'Enter Password'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                loginCall(_emailController.text, _passwordController.text).then((LoginResponse _loginResponse){
                  if (_loginResponse.status.success==false) {
                    print('errorMessage: ${_loginResponse.status.errorMessage}');
                    return Text(_loginResponse.status.errorMessage);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
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