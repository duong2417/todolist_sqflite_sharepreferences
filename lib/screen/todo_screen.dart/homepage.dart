import 'package:flutter/material.dart';
import 'package:flutter_todolist_8_4_23/screen/functions/badge.dart';

import 'package:flutter_todolist_8_4_23/screen/todo_screen.dart/todo_list_container.dart';
import 'package:flutter_todolist_8_4_23/screen/todo_screen.dart/header.dart';

import '../../bloc/todo_bloc.dart';
// import '../functions/dropdown_menu.dart';


const DARK_MODE= Colors.green;
class TodoSCREEN extends StatefulWidget {
  const TodoSCREEN({super.key});

  @override
  State<TodoSCREEN> createState() => _TodoSCREENState();
}

class _TodoSCREENState extends State<TodoSCREEN> {
TodoBLOC bloc = TodoBLOC();
// @override
//   void initState() {
//     super.initState();
//     if (bloc.listTODO.isNotEmpty) {//list empty nen ko print
//       int id = bloc.listTODO[bloc.listTODO.length - 1].id;
//       p("id init homepage",id);//0 //ham nay ko dc goi
      
      
//        }
//   }

  @override
  Widget build(BuildContext context) {
    // BADGE badge =BADGE();
    return Scaffold(
      // resizeToAvoidBottomInset:false,//ko đổi size (thu nhỏ) khi bàn phím xhien
      body: SafeArea(
        child: Container(
          padding:const EdgeInsets.all(10),
          child: Column(
            children:  [
               HEADER(),
             const TodoListCONTAINER(),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(onPressed: (){
      //   DropDownMENU().dropDownMENU();
      // },
      // child:badge.showBADGE()
      // ),
    );
  }
}
