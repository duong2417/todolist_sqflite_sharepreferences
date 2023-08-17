import 'package:flutter/material.dart';

class DropDownMENU{
final List<Widget> items=[const Text("Delete selected"),const Text("Save selected"),const Text("Set color"),const Text("Calendar")];

 Widget dropDownMENU(){
    
//  return DropdownButtonFormField(items: items.map((e) => DropdownMenuItem(child: Text(e))).toList(), onChanged: (item){
//       // setState((){});
//     });
return PopupMenuButton(
            padding:const EdgeInsets.all(2),
              position: PopupMenuPosition.under,
              splashRadius: 2,
              iconSize: 14, //size ctn
              tooltip: 'Nhap vao de ẩn',
              icon: const Icon(Icons.more_vert),
              itemBuilder: ((context) => [
                    PopupMenuItem(
                        child: items[0],
                        onTap: () => print('hide/show listview!')),
                    PopupMenuItem(
                        child: items[1],
                        onTap: () => print('route!')),
                    PopupMenuItem(
                        child: items[2],
                        onTap: () => print(
                            'Link to your personal app to receive notifications')),
                    PopupMenuItem(
                        child: items[3],
                        onTap: () => print('logout!')),
                  ]));
       
  }
}