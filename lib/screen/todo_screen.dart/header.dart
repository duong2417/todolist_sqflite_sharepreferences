import 'package:flutter/material.dart';
import 'package:flutter_todolist_8_4_23/bloc/todo_bloc.dart';
import 'package:flutter_todolist_8_4_23/event/add_event.dart';
import '../../debug.dart';
import '../../shared_preferences.dart/shared_preferences.dart';
import 'dialog.dart';
// import '../functions/dropdown_menu.dart';
// import 'dialog.dart';

class HEADER extends StatefulWidget {
  @override
  State<HEADER> createState() => HEADERState();
}

class HEADERState extends State<HEADER> {
int _id=0;

  TodoBLOC bloc = TodoBLOC();
  TextEditingController textCONTROLLER = TextEditingController();
final SharedPREFERENCES _prefs=SharedPREFERENCES();

@override
  void initState() {
    super.initState();
    //     _prefs.getSoCotCURRENT(bloc.soCOT);
    // p("soCOT init header",bloc.soCOT);
    if (bloc.listTODO.isNotEmpty) {//list empty nen ko print
      _id = bloc.listTODO[bloc.listTODO.length - 1].id;
      p("id init header",_id);//0 //ham nay ko dc goi
       }
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //   if (bloc.listTODO.isNotEmpty) {
    //   widget.id = bloc.listTODO.length - 1;
    // }
    // p("id init trong build header",widget.id);//0 //true

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            child: Row(
               children: [
              Expanded(
                child: GestureDetector(
                  // onDoubleTap:()   { 
                  //    DialogTODO.showDialogTODO(_id,context,textCONTROLLER);
                  // },
                  child: TextFormField(//todo me
                                          decoration:const InputDecoration(hintText:"DoubleClick following todo to edit",
                        // isCollapsed:true,//thanh duoi xich len tren
                        ),            
                          // autofocus:true,//để complete todo con thì con trỏ nhảy qua mẹ
                    maxLines: null,
                    controller: textCONTROLLER,
                  ),
                ),
              ),
             
                   SizedBox(width:50,
                     child: TextButton(
                      onPressed: () {
                        p("bloc.listTODO", bloc.listTODO); //[]
                        // demSoSNACKBAR = 0;
                                 
                             if (bloc.listTODO.isNotEmpty) {
                      _id = bloc.listTODO[bloc.listTODO.length - 1].id; //tránh bị trùng idid
                         
                     p("id init build",_id);//true
                       }
                       _id++;
                         
                        TodoBLOC.nhapSTREAM.sink.add(AddTodoEVENT(_id,
                          textCONTROLLER.text,
                        )); //BAN THAN BLOC DA CO SETSTATE
                        textCONTROLLER.text = '';}
                                      ,
                      child: const Text("Send"),
                     ),
                   ),
               
            ]),
          ),
        ),
      ],
    );
  }
}
