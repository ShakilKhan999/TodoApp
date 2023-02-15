import 'package:flutter/foundation.dart';
import 'package:todo/db/db_helper.dart';

import '../models/to_do_model.dart';

class TodoProvider extends ChangeNotifier{
  List<ToDoItem> todoList = [];
  getAllToDoItem(){
    DBHelper.getAllToDoItem().then((value){
      todoList = value;
      notifyListeners();
    });
  }
  Future<bool> addNewTodo(ToDoItem toDoItem) async{
    final rowId = await DBHelper.insertTodo(toDoItem);
    if(rowId>0){
      toDoItem.id = rowId;
      todoList.add(toDoItem);
      notifyListeners();
      return true;
    }return false;
  }
  updateChecked(int id, int value,int index){
    DBHelper.updateChecked(id, value).then((_) {});
    todoList[index].ischecked = !todoList[index].ischecked;
    notifyListeners();
  }
  deleteToDo(int id)  async{
    final rowId = await DBHelper.deleteToDo(id);
    if(rowId>0){
      todoList.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }

}