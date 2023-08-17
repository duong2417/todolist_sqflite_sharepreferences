import 'package:flutter/material.dart';
import 'package:flutter_todolist_8_4_23/db/open_database.dart';
// import 'package:flutter_todolist_8_4_23/screen/route.dart';
import 'package:flutter_todolist_8_4_23/screen/todo_screen.dart/homepage.dart';
import 'const/const.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OpenDATABASE.instance.init();//để db ko bị lỗi null check
// await TodoBLOC().initialData();//1 KI TU //Stream has already been listened
  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: PRIMARY_SWATCH,
      brightness: Brightness.dark,
      ),
      // initialRoute: ROUTE.splashSCREEN,
      // onGenerateRoute: ROUTE.onGenerateROUTE,
      home: const  TodoSCREEN(),
            ));
}
