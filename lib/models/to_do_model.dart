
const  String tableTodo ='table_todo';
const  String tableTodoColID ='id';
const  String tableTodoColTaskname ='taskname';
const  String tableTodoColIsChecked ='ischecked';
class ToDoItem{
  int? id;
  String taskname;
  bool ischecked;

  ToDoItem({
    this.id,
    required this.taskname,
    this.ischecked = false,
  });
  Map<String,dynamic>toMap(){
    var map = <String,dynamic>{
      tableTodoColTaskname:taskname,
      tableTodoColIsChecked:ischecked? 1:0,
    };
   if(id!=null){
     map[tableTodoColID] =id;
   }
    return map;
  }
  factory ToDoItem.fromMap(Map<String,dynamic> map) =>ToDoItem(
  id : map[tableTodoColID],
  taskname:map[tableTodoColTaskname],
    ischecked: map[tableTodoColIsChecked] == 1?true : false,
  );

  @override
  String toString() {
    return 'ToDoItem{id: $id, taskname: $taskname, ischecked: $ischecked}';
  }
}