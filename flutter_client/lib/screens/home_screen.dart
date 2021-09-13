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
    return Scaffold(
        appBar: AppBar(
          title: Text('USERS LIST'),
          automaticallyImplyLeading: false,
           actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateScreen(),
                  ),
                );
              },
              icon: Icon(Icons.settings),
              iconSize: 24.0,
            ),
          ],
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
                          return Card(
                            elevation: 2.0,
                            child: ListTile(
                              title:Text(listResponse.users[i].name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
                              trailing: Text(listResponse.users[i].email),
                            ),
                          );
                        },
                      )
                    )
                  ],
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeleteScreen(),
            ),
          );
        },
        tooltip: 'Delete',
        child: Icon(Icons.delete),
      ), 
    );
  }
}