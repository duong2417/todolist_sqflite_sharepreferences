import 'package:flutter_todolist_8_4_23/base/base_event.dart';

import '../model/todo_model.dart';

class UpdateTodoEVENT extends BaseEVENT{
  Todo todo;int index;
  UpdateTodoEVENT(this.todo,this.index);
}