import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './login_screen.dart';
import '../classes/common.dart';
import '../config/config.dart';

Future<Response> registerCall(String name, email, password, confirmPassword) async{
  final response = await http.post(
    Uri.parse('$BASE_URL/register'),
    headers: headers,
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
  
  return Response.fromJson(jsonDecode(response.body));
}

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _name, _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('AUTH', style: TextStyle(fontSize: 50.0, fontFamily: 'Ethnocentric',),),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Name'),
                        validator: (input) => input.trim().isEmpty
                            ? 'Please enter a valid Name'
                            : null,
                        onSaved: (input) => _name = input,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (input) => !input.contains('@')
                            ? 'Please enter a valid Email'
                            : null,
                        onSaved: (input) => _email = input,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (input) => input.length < 6
                            ? 'Password must be atleast 6 characters'
                            : null,
                        onSaved: (input) => _password = input,
                        obscureText: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(labelText: 'Confirm Password'),
                        validator: (input) => input.length < 6
                            ? 'Password must be atleast 6 characters'
                            : null,
                        onSaved: (input) => _confirmPassword = input,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: (){
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();

                          setState(() {
                            registerCall(_name, _email, _password, _confirmPassword).then((Response _response){
                              if (_response.status.success == false){
                                print('errorMessage: ${_response.status.errorMessage}');
                                return Text(_response.status.errorMessage);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            });
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:20.0, vertical:10.0),
                        child: const Text('REGISTER',style: TextStyle(color: Colors.white, fontSize: 18.0)),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:20.0, vertical:10.0),
                        child: const Text('Go to Login',style: TextStyle(color: Colors.white, fontSize: 18.0)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
