import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './home_screen.dart';
import './register_screen.dart';
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
  final _formKey = GlobalKey<FormState>();
  String _email, _password;

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
                        validator: (input) => input.length < 1
                            ? 'Password can not be empty'
                            : null,
                        onSaved: (input) => _password = input,
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
                            loginCall(_email, _password).then((LoginResponse _response){
                              if (_response.status.success == false){
                                print('errorMessage: ${_response.status.errorMessage}');
                                return Text(_response.status.errorMessage);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeScreen(),
                                ),
                              );
                            });
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:50.0, vertical:10.0),
                        child: const Text('LOGIN',style: TextStyle(color: Colors.white, fontSize: 18.0)),
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
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal:20.0, vertical:10.0),
                        child: const Text('Go to Register',style: TextStyle(color: Colors.white, fontSize: 18.0)),
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
