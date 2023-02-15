import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/newtodo_page.dart';
import 'package:todo/pages/to_do_items.dart';
import 'package:todo/providers/todo_provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context)=> TodoProvider() ..getAllToDoItem())
    ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.yellow,
      ),
      initialRoute: ToDoItems.routename,
      routes: {
        ToDoItems.routename:(context)=>ToDoItems(),
        NewToDoPage.routename:(context)=> NewToDoPage()
      },
    );
  }
}
