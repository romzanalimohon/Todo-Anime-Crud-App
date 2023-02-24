import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPage extends StatefulWidget {

  var item;
  DetailPage({this.item});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  var data;

  @override
  void initState() {
    super.initState();
    final id = widget.item;
    singleFetchTodo(id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(widget.item['id'].toString()),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image.network(widget.item['image'], height: 400,),
              // Text(widget.item['username'], style: TextStyle(fontSize: 25),),
              // Text(widget.item['password'], style: TextStyle(fontSize: 25),)
              Image.network(data['user']['image']),
              Text(data['user']['username'], style: TextStyle(fontSize: 35),)
            ],
          ),
        )
      ),
    );
  }


Future singleFetchTodo(int id) async{

  final url = 'http://192.168.0.102:5000/users/$id';
  final uri = Uri.parse(url);
  var response = await http.get(uri);
  setState(() {
    var decode = json.decode(response.body);
    data = decode;
    //print(data);
  });
  //print(data);
  print(data);
  print('its working');


}


}

