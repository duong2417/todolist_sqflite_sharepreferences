// import 'dart:math';

import 'package:flutter_todolist_8_4_23/export/export.dart';

class TodoBLOC extends BaseBLOC {
  List<bool> readONLY = []; //toan cuc de ko bi reset
  int id = 0;
  //  int soCOT=3;
  static StreamController<BaseEVENT> nhapSTREAM = StreamController<
      BaseEVENT>.broadcast(); //phai static no moi hien listview//phai broadcast moi het has been listened
  final StreamController<List<Todo>> _xuatSTREAM =
      StreamController<List<Todo>>();
  List<Todo> listTODO =
      []; //để lưu data kiểu List<Todo> not Future<List<Todo>> của selectAll -> bloc mới in data ra đ                             c
  StreamController<List<Todo>> get xuatSTREAM => _xuatSTREAM;

  initialDATA() async {
    listTODO = await _bang.selectAll();
    _xuatSTREAM.sink.add(listTODO); //compulsory
    // readONLY.clear();
    // for (int i = 0; i < listTODO.length; i++) {
    //   readONLY.add(true); //compulsory
    // }
  }

  readOnlyFUNC(int leng) {
    // readONLY.clear();
    int i;
    if (readONLY.isEmpty) {
      p("read empty $leng ", readONLY.length); //4 : 0

      for (i = 0; i < leng; i++) {
        readONLY.add(true); //compulsory
      }
    } else if (readONLY.length < leng) {
      //them ptu (send todo me)
      p("len > $leng ", readONLY.length);

      for (i = 0; i < leng - readONLY.length; ++i) {
        readONLY.add(true);
      }
    } else if (readONLY.length > leng) {
      //xoa ptu
// readONLY.forEach(((element) {
// if (element==false);

// }));
      p("len < $leng ", readONLY.length);
      for (i = 0; i < leng; i++) {
        readONLY[i] = true; //set toàn bộ = true
      }
      // readONLY.removeRange(readONLY.length-leng,readONLY.length);
      p("readONLY.removeRange", readONLY);
    }
  }

  final ThaoTacVoiBANG _bang = ThaoTacVoiBANG();
  void undoTODO(UndoTodoEVENT event) async {
    await _bang.insertTodo(event.todo);
    // p("GridVIEW.id undo",GridVIEW.id);

// listTODO.add(event.todo);
    p("event.vitri", event.vitri);
    if (listTODO.isNotEmpty) {
//   if (listTODO.length<=event.vitri)
//   {
// p("leng < vitri ${listTODO}",event.vitri);
// for (int i = event.vitri-listTODO.length; i<= event.vitri;++i){
//   listTODO.add(Todo(-1,"test"));

//   }}
      if (listTODO.length >= event.vitri) {
        //otherwise bị "not in inclusive range 0..1: 3"

        p("event.vitri2", event.vitri);

        listTODO.insert(event.vitri, event.todo);
      }
    }

    _xuatSTREAM.sink.add(listTODO); //để setState ra màn hình
    closeWhenOPENED();
  }

  void addTODO(Todo todo) async {
    await _bang.insertTodo(todo);
    listTODO.add(todo); //add 2 lan: init voi anddEVENT
    p("listTODO add", listTODO);

    _xuatSTREAM.sink.add(listTODO);
    closeWhenOPENED(); //add todo rồi, thì readONLY mới ko bị lỗi range do index cuối > listTODO.length -> vựơt quá 1 ptu (readONLY.length=listTODO.length)
  }

  void deleteTODO(DeleteTodoEVENT event) async {
    await _bang.deleteTodo(event.todo);
    listTODO.remove(event.todo);
    _xuatSTREAM.sink.add(listTODO);
  }

  void updateTODO(UpdateTodoEVENT event) async {
    await _bang.updateTodo(event.todo);
    listTODO = await _bang.selectAll();
    p("event.todo.id", event.todo.id);

    //  p("update listTODO",listTODO);
    //  if (listTODO.isNotEmpty) {//rebuild thì only valid value is 0 (ptu mới nhât) do listTODO chỉ đc init duy nhât lần firstbuild
    //    listTODO[event.index]=event.todo;
    //  }
    // listTODO[event.todo.id]=event.todo;
    p("replace listTODO", listTODO);

    xuatSTREAM.sink.add(listTODO);
    p("xuatSTREAM listTODO", listTODO);
  }

  TodoBLOC() {
    p("id todoBLOC", id);

    nhapSTREAM.stream.listen((BaseEVENT event) {
      if (listTODO.isNotEmpty) {
        id = listTODO[listTODO.length - 1].id + 1;
        p("id listen", id);
      } else
        id = 0;
      if (event is AddTodoEVENT) {
        // int id = Random().nextInt(1000);
        // p("GridVIEW.id",GridVIEW.id);
        Todo todo = Todo(id, event.content);
        addTODO(todo);
        // closeWhenOPENED();//đồng bộ (await ko có td): chạy đồng thời nào có KQ trước thì thực hiện trc nên ko thể đặt hàm này ở đây mà chuyển lên hàm bất đồng bộ addTODO
      } else if (event is DeleteTodoEVENT) {
        deleteTODO(event);
      } else if (event is ReadOnlyEVENT) {
        closeWhenOPENED();
        //  maxLinesTodoCON = 2;
        if (readONLY.length > event.index!) {
          readONLY[event.index!] = false;
        } //tắt chỉ đọc
      } else if (event is UpdateTodoEVENT) {
        updateTODO(event);
      } else if (event is UndoTodoEVENT) {
        undoTODO(event);
      } else if (event is SliderEVENT) {
        // TodoListCONTAINERState.sizeText--;
        // soCOT = event.value.toInt();
        _xuatSTREAM.sink
            .add(listTODO); //compulsory, có này nó mới builder lại gridview
      }
      // xuatSTREAM.sink.add(listTODO);//disabled
    });
  }
  dynamic closeWhenOPENED() {
    //doubleTap todo khac thi todo nay reaOnly
    {
      readONLY = [];
      for (int i = 0; i < listTODO.length; i++) {
        readONLY.add(true);
      } //size readONLY va size listTODO dong thoi cùng bằng nhau
    }
  }

  void dispose() async {
    nhapSTREAM.close(); //ko cho stream lang nghe nua
    _xuatSTREAM.close();
    await _bang.closeDB();
  }
}
