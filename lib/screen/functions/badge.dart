import 'package:flutter/material.dart';
import 'package:flutter_todolist_8_4_23/bloc/todo_bloc.dart';

import '../../model/todo_model.dart';


class BADGE{
  TodoBLOC bloc=TodoBLOC();
 Widget showBADGE(){
  return Badge(label:StreamBuilder<List<Todo>>(
    stream: bloc.xuatSTREAM.stream,
    builder: (context, snapshot) {
      return snapshot.hasData ? Text(snapshot.data!.length.toString()):const Text("-1");
    }
  ),
  //  child: const Icon(Icons.barcode_reader)
  );
 }
}