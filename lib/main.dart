import 'package:flutter/material.dart';

import 'screens/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: TodoListPage(),
    );
  }
}
