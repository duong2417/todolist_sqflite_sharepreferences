
import 'package:flutter_todolist_8_4_23/base/base_event.dart';


class AddTodoEVENT extends BaseEVENT{
String content; 
int id;
// Todo todo;
 AddTodoEVENT(
  this.id,
  this.content) ;
}