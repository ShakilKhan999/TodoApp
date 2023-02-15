import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';

import '../db/db_helper.dart';
import '../models/to_do_model.dart';

class NewToDoPage extends StatefulWidget {
  static const String routename ='/newtodo';
  const NewToDoPage({Key? key}) : super(key: key);

  @override
  State<NewToDoPage> createState() => _NewToDoPageState();
}

class _NewToDoPageState extends State<NewToDoPage> {
  final todoitemscontroller = TextEditingController();
  @override
  void dispose() {
    todoitemscontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow,
      title: const Center(child: Text('Add a new task ')),
      actions: [
        TextField(
          controller: todoitemscontroller,
          decoration: InputDecoration(
              border: OutlineInputBorder()
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(onPressed: _saveToDo, child: Text('Save',style: TextStyle(color: Colors.black))),
            TextButton(onPressed: (){
              Navigator.pop(context);
            },
                child: Text('Cancel',style: TextStyle(color: Colors.black),))
          ],
        )
      ],
    );
  }

  void _saveToDo() async{
    final todoItem = ToDoItem(taskname:todoitemscontroller.text);
    print(todoItem.toString());
    final status = await Provider.of<TodoProvider>(context,listen: false).addNewTodo(todoItem);
    if(status){
      Navigator.pop(context);
    }
  }

}
