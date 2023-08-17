// import 'package:flutter/cupertino.dart';
// import 'package:flutter_todolist_8_4_23/export/export.dart';

// class DialogTODO {
//   ScrollController scroll = ScrollController();
//   static void showDialogTODO(
//       BuildContext context, TextEditingController controller) {
//     showCupertinoModalPopup(
//       // barrierLabel:"X",
//       barrierDismissible:false,
//       context: context,
//       builder: (BuildContext context) {
//         return CupertinoApp(
//           home: CupertinoAlertDialog(
//               content: Material(
//                 child: Padding(
//                   padding:const EdgeInsets.all(8),
//                   child: SizedBox(height:100,child: TextFormField(maxLines: 10, controller: controller))),
//               ),
//                 actions:[
//                   CupertinoDialogAction(child: const Text("Color"),onPressed:(){}),
//                   CupertinoDialogAction(child: const Text("Archieved"),onPressed:(){}),
//                 ],
//         // actionScrollController:ScrollController(),
//             ),
//         );
//       },
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_todolist_8_4_23/bloc/todo_bloc.dart';
import 'package:flutter_todolist_8_4_23/event/update_event.dart';

import '../../db/thao_tac_voi_bang.dart';
import '../../debug.dart';
import '../../model/todo_model.dart';
class DialogTODO{
  ThaoTacVoiBANG _bang=ThaoTacVoiBANG();
 Future<void> showDialogTODO(int id,BuildContext context, TextEditingController controller,int index) async {
	return showDialog<void>(
	  context: context,
	  barrierDismissible: false, // user must tap button!
	  builder: (BuildContext context) {
	    return AlertDialog(
	      title: const Text('Add a new todo item'),
	      content: TextField(
          maxLines:10,
	        controller: controller,
	        decoration: const InputDecoration(hintText: 'Type your new todo'),
	      ),
	      actions: <Widget>[
	        TextButton(
	          child: const Text('Update'),
	          onPressed: () {
              // TodoBLOC.nhapSTREAM.sink.add(UpdateTodoEVENT(Todo(id,controller.text ),index));//setState lại mất tiêu
_bang.updateTodo(Todo(id,controller.text));

	            Navigator.of(context).pop();
                // _addTodoItem(_textFieldController.text);
                p("id dialog",id);
	          },
	        ),  TextButton(
	          child: const Text('COLOR'),
	          onPressed: () {
	            Navigator.of(context).pop();
// TodoBLOC.nhapSTREAM.sink.add(AddTodoEVENT(id, controller.text));
                // _addTodoItem(_textFieldController.text);
                p("COLOR",id);
	          },
	        )
	      ],
	    );
	  },
	);
}
}