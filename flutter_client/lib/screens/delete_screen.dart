import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../classes/common.dart';
import '../config/config.dart';

Future<Response> deleteCall(String email, password) async{
  final response = await http.delete(
    Uri.parse('$BASE_URL/delete'),
    headers: headers,
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode != 200) {
    print('Failed to create user. \n StatusCode: ${response.statusCode}');  
  }
  
  return Response.fromJson(jsonDecode(response.body));
}

class DeleteScreen extends StatefulWidget {
  @override
  _DeleteScreenState createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('DELETE'),
        ),
      body: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(hintText: 'Enter Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(hintText: 'Enter  Password'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                deleteCall(_emailController.text, _passwordController.text).then((Response _deleteResponse){
                  if (_deleteResponse.status.success==false) {
                    print('errorMessage: ${_deleteResponse.status.errorMessage}');
                    return Text(_deleteResponse.status.errorMessage);
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