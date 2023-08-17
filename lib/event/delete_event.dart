import 'package:flutter_todolist_8_4_23/base/base_event.dart';
import 'package:flutter_todolist_8_4_23/model/todo_model.dart';

class DeleteTodoEVENT extends BaseEVENT{
Todo todo; //vi list remove Todo
DeleteTodoEVENT(this.todo);
}