import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/pages/newtodo_page.dart';
import 'package:todo/providers/todo_provider.dart';

import '../models/to_do_model.dart';

class ToDoItems extends StatefulWidget {
  static const String routename = '/';

  const ToDoItems({Key? key}) : super(key: key);

  @override
  State<ToDoItems> createState() => _ToDoItemsState();
}

class _ToDoItemsState extends State<ToDoItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Center(child: Text('To Do')),
        elevation: 0,
      ),
      body: Consumer<TodoProvider>(
        builder: (context, provider, _) => ListView.builder(
            itemCount: provider.todoList.length,
            itemBuilder: (context, index) {
              final todo = provider.todoList[index];
              return Padding(
                padding: const EdgeInsets.only(top: 30, left: 24, right: 24),
                child: Slidable(
                    endActionPane: ActionPane(
                      motion: StretchMotion(),
                      children: [
                        SlidableAction(
                            onPressed: (value){
                              setState(() {
                                final value =todo.id!;
                                provider.deleteToDo(todo.id!);
                              });

                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            borderRadius: BorderRadius.circular(10))
                      ],
                    ),
                    child: Container(
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Checkbox(
                              value: todo.ischecked,
                              onChanged: (value) {
                                setState(() {
                                  final value = todo.ischecked ? 0 : 1;
                                  provider.updateChecked(
                                      todo.id!, value, index);
                                });
                              },
                              activeColor: Colors.black,
                            ),
                            Text(
                              todo.taskname,
                              style: TextStyle(
                                  decoration: todo.ischecked
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            )
                          ],
                        ))),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewToDoPage.routename);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}
