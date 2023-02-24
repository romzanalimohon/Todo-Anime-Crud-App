import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todo_anime_crud_app/screens/detail%20page/detail.dart';

import 'add_page.dart';

String ip = "192.168.0.102";

class TodoListPage extends StatefulWidget {


  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  List items = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('List'),),

      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator(),),
        replacement: RefreshIndicator(
          onRefresh: fetchTodo,
          child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index){
                final item = items[index] as Map;
                final id = item['id'] as int;
                return GestureDetector(
                  onTap: (){
                    setState(() {
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(items[index])));
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(item: id)));
                      //print(items[index]);
                      //print(id);
                    });
                  },
                  child: ListTile(
                    //leading: CircleAvatar(child: Image.network("${item['image']}") ),
                    //leading: CircleAvatar(child: Image.network(item['image']),),
                    //leading: CircleAvatar(child: Text(item['id'].toString()),),
                    leading: CircleAvatar(child: Text(id.toString()),),
                    title: Text(item['username'], ),
                    //subtitle: Text(item['password'], ),
                    trailing: PopupMenuButton(

                      onSelected: (value){
                        if(value == 'edit'){
                          navigateToEditPage(item);
                        }else if(value == 'delete'){
                          deleteById(id);
                        }
                      },
                      itemBuilder: (context){
                        return [
                          PopupMenuItem(child: Text('Edit'), value: 'edit',),
                          PopupMenuItem(child: Text('Delete'), value: 'delete',)
                        ];
                      },
                    ),
                  ),
                );
              }),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        label: Icon(Icons.add),
        onPressed: navigateToAddPage,
      ),
    );
  }

  Future<void> navigateToAddPage() async{
    final route = MaterialPageRoute(builder: (context)=> AddTodoPage());
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> navigateToEditPage(Map item) async{
    final route = MaterialPageRoute(builder: (context)=> AddTodoPage(user: item));
    await Navigator.push(context, route);
    setState(() {
      isLoading = true;
    });
    fetchTodo();
  }

  Future<void> deleteById(int id) async{
    final url = 'http://$ip:5000/users/$id';
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if(response.statusCode == 200){
      final filtered = items.where((element)=> element['id'] != id).toList();
      setState(() {
        items = filtered;
      });
      showSuccessMessage('data deleted');
    }else{
      showErrorMessage('delete failed');
    }
  }

  Future<void> fetchTodo() async{
    setState(() {
      isLoading = true;
    });
    final url = 'http://$ip:5000/users';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200){
      final json = jsonDecode(response.body) as Map;
      final result = json['users'] as List;
      setState(() {
        items = result;
      });
    }
    setState(() {
      isLoading = false;
    });
  }






  void showSuccessMessage(String message){
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message){
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    );
  }

}
