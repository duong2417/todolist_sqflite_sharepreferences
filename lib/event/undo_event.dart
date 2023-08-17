import '../base/base_event.dart';
import '../model/todo_model.dart';

class UndoTodoEVENT extends BaseEVENT{
  Todo todo;
  int vitri;
UndoTodoEVENT(this.todo,
this.vitri
);
}