import 'package:flutter_todolist_8_4_23/const/const.dart';
import 'package:flutter_todolist_8_4_23/db/open_database.dart';
import 'package:flutter_todolist_8_4_23/model/todo_model.dart';
import 'package:sqflite/sqflite.dart';

class ThaoTacVoiBANG {
    final Database db = OpenDATABASE.instance.db;

  Future<List<Todo>> selectAll() async {
    List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);
    return List.generate(
      maps.length,
      (index) => Todo(maps[index]['id'], maps[index]['content']),
    );
  }

  Future<Future<int>> insertTodo(Todo todo) async {
    return db.insert(TABLE_NAME, todo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> deleteTodo(Todo todo) {
    return db.delete(
      TABLE_NAME,
      where: 'id=?',
      whereArgs: [todo.id],
    );
  }

  Future<void> updateTodo(Todo todo) {
    return db.update(//REPLACE
      TABLE_NAME,
      todo.toMap(),
      where: 'id=?',
      whereArgs: [todo.id],
    );
  }
    Future closeDB() async => db.close();
}
