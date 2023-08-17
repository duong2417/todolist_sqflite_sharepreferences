
import 'package:flutter/material.dart';

class Todo{
   int id;String content;
  Todo(this.id,this.content);
  Map<String,dynamic> toMap(){
    return {"id":id,"content":content};
  }
   static TextStyle? getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }
  @override
  toString()=> "id:$id,content:$content";
}