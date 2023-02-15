 import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models/to_do_model.dart';

class DBHelper{

  static const String createTableTodo = '''create table $tableTodo(
  $tableTodoColID integer primary key,
  $tableTodoColTaskname text,
  $tableTodoColIsChecked int
  )''';

  static Future<Database> open() async{
    final rootPath = await getDatabasesPath();
    final dbpath = join(rootPath,'todo.db');
    return openDatabase(dbpath,version: 2,onCreate: (db,version){
      db.execute(createTableTodo);
    });
  }
  static Future<int> insertTodo(ToDoItem toDoItem) async{
    final db = await open();
    return db.insert(tableTodo, toDoItem.toMap());
  }
  static Future<List<ToDoItem>> getAllToDoItem() async{
    final db = await open();
    final List<Map<String,dynamic>> mapList =await  db.query(tableTodo);
    return List.generate(mapList.length, (index) => ToDoItem.fromMap(mapList[index]));
  }
  static Future<int> updateChecked(int id ,int value) async{

    final db = await open();
    return db.update(tableTodo, {tableTodoColIsChecked:value},where:'$tableTodoColID =?',whereArgs: [id] );
  }
  static Future<int> deleteToDo(int id)  async{
    final db = await open();
    return db.delete(tableTodo,where: '$tableTodoColID =?',whereArgs: [id]);
  }


 }