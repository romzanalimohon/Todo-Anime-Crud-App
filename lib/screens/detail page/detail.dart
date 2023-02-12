import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class DetailPage extends StatefulWidget {

  var item;
  DetailPage(this.item);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.item['username']+' Info'),),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(widget.item['image']),
              Text(widget.item['username'])
            ],
          ),
        )
      ),
    );
  }

  // Future singleFetchTodo(int id) async{
  //
  //   final url = 'http://192.168.0.103:5000/users/$id';
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //
  // }


}

