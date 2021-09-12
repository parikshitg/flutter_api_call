import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../classes/common.dart';
import '../config/config.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

Future<Response> updateCall(String email, oldPassword, newPassword, confirmPassword) async{
  final response = await http.patch(
    Uri.parse('$BASE_URL/update-password'),
    headers: headers,
    body: jsonEncode(<String, String>{
      'email': email,
      'old_password':oldPassword,
      'new_password':newPassword,
      'confirm_password':confirmPassword,
    }),
  );

  if (response.statusCode != 200) {
    print('Failed to create user. \n StatusCode: ${response.statusCode}');  
  }
  
  return Response.fromJson(jsonDecode(response.body));
}

class _UpdateScreenState extends State<UpdateScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('UPDATE'),
        ),
      body: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: 'Enter Email'),
          ),
          TextField(
            controller: _oldPasswordController,
            decoration: const InputDecoration(hintText: 'Enter Old Password'),
          ),
          TextField(
            controller: _newPasswordController,
            decoration: const InputDecoration(hintText: 'Enter New Password'),
          ),
          TextField(
            controller: _confirmPasswordController,
            decoration: const InputDecoration(hintText: 'Enter Confirm Password'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                updateCall(_emailController.text, _oldPasswordController.text, _newPasswordController.text, _confirmPasswordController.text).then((Response _updateResponse){
                  if (_updateResponse.status.success==false) {
                    print('errorMessage: ${_updateResponse.status.errorMessage}');
                    return Text(_updateResponse.status.errorMessage);
                  }
                  return Text('Successfully updated');
                });
              });
            },
            child: const Text('Update Password'),
          ),
        ],
      ),
     ),
    );
  }
}