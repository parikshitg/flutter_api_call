import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../classes/list.dart';
import '../config/config.dart';
import './update_screen.dart';
import './delete_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

ListResponse listResponse;

Future<ListResponse> listCall() async{
  final response = await http.get(
    Uri.parse('$BASE_URL/list'),
    headers: headers,
  );

  if (response.statusCode != 200) {
    print('Failed to create user. \n StatusCode: ${response.statusCode}');  
  }
  
  listResponse = ListResponse.fromJson(jsonDecode(response.body));
  return listResponse;
}

class _HomeScreenState extends State<HomeScreen> {
  Future<ListResponse> _response;
  
  @override
  void initState() {
    super.initState();
    _response = listCall();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HOMESCREEN')
        ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<ListResponse>(
              future: _response,
              builder:(context, users){
                if (!users.hasData) {
                    return Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    Container(
                      child: ListView.builder(
                        primary: false,
                        itemCount: listResponse.users.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i){
                          return Text(listResponse.users[i].name);
                        },
                      )
                    )
                  ],
                );
              }
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateScreen(),
                  ),
                );
              },
              child: const Text('Update Password'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeleteScreen(),
                  ),
                );
              },
              child: const Text('Delete User'),
            ),
          ],
        ),
      ),
      ),
    );
  }
}