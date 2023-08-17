
import 'package:flutter/material.dart';

class DropdownMENU extends StatelessWidget {
  // const DropdownMENU({super.key});
List<String> items=["Delete selected","Save selected","Set color","Calendar"];
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(items: items.map((e) => DropdownMenuItem(child: Text(e))).toList(), onChanged: (item){
      // setState((){});
    });
  }
}