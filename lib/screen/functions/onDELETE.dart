
import 'package:flutter/material.dart';

import '../../bloc/todo_bloc.dart';
import '../../event/delete_event.dart';
import '../../event/undo_event.dart';
import '../../model/todo_model.dart';

void onDELETE(Todo todo,int dem,BuildContext context, int vitri) {
//   TodoBLOC bloc=TodoBLOC();
// if (bloc.listTODO.isNotEmpty){//compulsory, ko thì nó bị lỗi only valid value is 0
//   int vitri = bloc.listTODO.indexOf(todo);
//   p("vitri",vitri);
//   p("vitri list",bloc.listTODO);
//   }
       

    TodoBLOC.nhapSTREAM.sink.add(DeleteTodoEVENT(todo));
    ++dem;
    var snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text("$todo is deleted"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: ()  {

            //  ThaoTacVoiBANG().insertTodo(todo);
             TodoBLOC.nhapSTREAM.sink.add(UndoTodoEVENT(todo,vitri));//setState StreamBuilder (gọi hàm builder)
          }),
    );

    if (dem <= 3) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

