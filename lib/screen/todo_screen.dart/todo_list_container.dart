import 'package:flutter_slidable/flutter_slidable.dart';
import '../../export/export.dart';
// import '../functions/onEditingCOMPLETE.dart';
import '../../shared_preferences.dart/shared_preferences.dart';
import 'dialog.dart';

class TodoListCONTAINER extends StatefulWidget {
  const TodoListCONTAINER({super.key});

  @override
  State<TodoListCONTAINER> createState() => TodoListCONTAINERState();
}

class TodoListCONTAINERState extends State<TodoListCONTAINER> {
  TodoBLOC bloc = TodoBLOC();
  final SharedPREFERENCES _prefs = SharedPREFERENCES();
  bool lineTHROUGH = false;

  List<FocusNode> _node = [];

  int soCOT = 4;
  List<TextEditingController> _controllers = [];
  // GlobalKey? key;
  ThaoTacVoiBANG bang = ThaoTacVoiBANG();
  static int sizeText = 14;
  int demSoSNACKBAR = 0; //de trong build thi bi reset

  TextEditingController textCONTROLLER = TextEditingController();
  static bool showIconADD = false;
  static int maxLinesTodoCON = 1;
  get controllers => _controllers;
  // @override
  // void initState()  {
  //   //chi 1 lan duy nhat

  //   super.initState();
  //   // bloc.initialDATA(); //luc dau chay thi list=[], den ham buil thi chay nua moi lay dc ptu
  //   p("bloc.listTODO init", bloc.listTODO); //[] at first of all
  //   p("_controllers init", _controllers);
  //   // if (bloc.listTODO.isNotEmpty) {
  //   //   id = bloc.listTODO[bloc.listTODO.length - 1].id;
  //   //  p("id init",id);//0
  //   //    }

  //   soCOT=await _prefs.getSoCotCURRENT();
  // // //   p("soCOT init",soCOT);
  // }

  bool showLineTHROUGH() => lineTHROUGH = !lineTHROUGH;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await bloc.initialDATA(); //luc dau chay thi list=[], den ham buil thi chay nua moi lay dc ptu
    // if (bloc.listTODO.isNotEmpty){
    //   p("bloc.listTODO didChange",bloc.listTODO);
    //      readONLY.clear();
    //   for (int i = 0; i < bloc.listTODO.length; i++) {
    //     readONLY.add(true); //compulsory
    //   }
    // }
      soCOT=await _prefs.getSoCotCURRENT();

  }

  //   @override
  // Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   switch (state) {
  //     case AppLifecycleState.inactive:
  //        _prefs.storedSoCOT(soCOT);
  //   p("AppLifecycleState inactive ",soCOT);
  //   break;
  //     case AppLifecycleState.paused:
  //        _prefs.storedSoCOT(soCOT);
  //   p("AppLifecycleState paused ",soCOT);
  //   break;
  //     case AppLifecycleState.detached:
  //       _prefs.storedSoCOT(soCOT);
  //   p("detached ",soCOT);
  //       break;
  //     case AppLifecycleState.resumed:
  //          _prefs.storedSoCOT(soCOT);
  //   p("AppLifecycleState resume ",soCOT);
  //       break;
  //   }
  // }

  List<bool> _showIconADD = [];

  @override
  Widget build(BuildContext context) {
    //  bloc.readONLY.add(true);

    //  if (bloc.listTODO.isNotEmpty) {
    //   // id = bloc.listTODO.length-1;//useless

    //  p("id init build container",id);//0
    //    }

// int soCOT=bloc.soCOT;

    print("build: ${bloc.readONLY}; ${bloc.listTODO}");
    p("socot trc get BUILD", soCOT);
    //  _prefs.getSoCotCURRENT(soCOT);
    p("socot SAU get BUILD", soCOT);

    p("soCOT build", soCOT);
    return Expanded(
      //compul
      child: Column(
        children: [
          Slider(
            min: 1,
            max: 4,
            // label: soCOT.round().toString(), //ROUND=LAM TRON
            onChanged: (double value) {
              //    setState(() //compulsory, ko có nó thì chỉ update gridview chứ ko update thanh slider do setState goi hàm build trong class này còn sink.add thì gọi streambuilder (gridview)

              // {
              _prefs.storedSoCOT(soCOT);
              p("socot dc stored", soCOT);

              soCOT = value.toInt();

              // switch(soCOT){
              //     // case 1: TodoListCONTAINERState.sizeText = 18; //gọi TodoListCONTAINERState (update sizeText) rồi lần 2 mới update slider và update sizeText lần nữa
              //     case 1: sizeText = 18;

              //     break;
              //     case 2: sizeText = 15;
              //     // TodoListCONTAINERState.maxLinesTodoCON = 3;//ko thay đổi j
              //      break;
              //     case 3: sizeText = 14;
              //     // TodoListCONTAINERState.maxLinesTodoCON = 5;
              //     break;
              //     case 4: sizeText = 10;
              //     // TodoListCONTAINERState.maxLinesTodoCON = 6;

              //      break;
              //    }

              TodoBLOC.nhapSTREAM.sink.add(SliderEVENT(value));
              setState(() {});
              // }
              // );
            },
            value: soCOT.toDouble(), //currentSliderValue
            divisions: 3, //số phân đoạn (số chấm tròn nhỏ trên thanh slider)
          ),
          SlidableAutoCloseBehavior(
            child: StreamBuilder<List<Todo>>(
                //type snapshot.data
                stream: bloc.xuatSTREAM.stream,
                builder: ((BuildContext context,
                    AsyncSnapshot<List<Todo>> snapshot) {
                  _node = [];
                  _controllers = []; //reset để tránh _controllers
                  print("BUILDER: ${bloc.readONLY}; ${bloc.listTODO}");

                  if (snapshot.hasData) {
                    bloc.readOnlyFUNC(
                        snapshot.data!.length); //true -> false roi lai true hết

                    return Expanded(
                      //compulsory
                      child: GridView.builder(
                        shrinkWrap:
                            false, //true thì bị lỗi overscroll of a horizontal ListView inside another ListView

                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(
                              "itemBUILDER(co builder chac chan co itembuilder): ${bloc.readONLY}; ${bloc.listTODO}");
                          // if (snapshot.hasData) {
                          Todo todo = snapshot.data![index];
                          p("todo gridview", todo);

                          _showIconADD.add(false);
                          _node.add(FocusNode());
                          _controllers.add(TextEditingController());
                          p("__controllers.length", _controllers.length);
                          _controllers[index].text = todo.content;

                          return itemBUILDER(todo, index);
                          // }
                          // return const Center(child:Text("gridview has no data"));
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: soCOT,
                          mainAxisExtent: 50,
                          childAspectRatio: 1 / 10, //rong/cao
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4.0,
                        ),
                      ),
                    );
                  }
                  return const Center(
                      child: Text(
                          "No data")); //đang có mà xóa hêt thì hiện no data chứ ko phải circulorprogressindicator
                })),
          ),
        ],
      ),
    );
  }

  // void onEditingCOMPLETE(
  //     Todo todo, TextEditingController controller, int index) {
  // return  TodoBLOC.nhapSTREAM.sink
  //       .add(UpdateTodoEVENT(Todo(todo.id, controller.text), index));
  // }

  Widget itemBUILDER(Todo todo, int index) {
//     onTapOutside() {
//           TodoBLOC.nhapSTREAM.sink
//                   .add(UpdateTodoEVENT(Todo(todo.id, _controllers[index].text), index));
// //  bloc.readONLY = [];
// //       for (int i = 0; i <bloc.listTODO.length; i++) {
// //         bloc.readONLY.add(true);
// //       } //size readONLY va size listTODO dong thoi cùng bằng nhau
//   }
    p("index itemBUILDER", index);
    int vitri = 0;
    // p("itemBUILDER ${bloc.soCOT}",bloc.listTODO);
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
          motion: const BehindMotion(),
          dismissible: DismissiblePane(
              //chạy qua luôn, container đỏ chiếm full
              // confirmDismiss: () async {
              //   //điều kiện để khung Delete biến mất (khi nào xóa todo xong mới setstate và biến mất)
              //   await onDismiss(context,
              //       snapshot.data![index]);
              //   return true;
              // },

              onDismissed: () {
            //trượt qua
            if (bloc.listTODO.isNotEmpty) {
              //compulsory, ko thì nó bị lỗi only valid value is 0
              vitri = bloc.listTODO.indexOf(todo);
              p("vitri", vitri);
              p("vitri list", bloc.listTODO);
            }

            onDELETE(todo, demSoSNACKBAR, context, vitri);
          }),
          children: [
            SlidableAction(
                // 1/2 screen là dừng chứ ko chạy qua lun
                backgroundColor: Colors.red,
                icon: Icons.delete,
                label: 'Delete',
                onPressed: (context) {
                  onDELETE(todo, demSoSNACKBAR, context, vitri);
                }),
          ]),
      child: GestureDetector(
        onDoubleTap: () {
          FocusScope.of(context).requestFocus(_node[index]);
          if (bloc.listTODO.isNotEmpty) {
            for (int i = 0; i < bloc.listTODO.length; ++i) {
              _showIconADD[i] = false;
            }
          }
          _showIconADD[index] = true;
          //value 
          // TodoBLOC.nhapSTREAM.sink.add(ReadOnlyEVENT(index));//lỗi _lastTapDownPosition is null
          _showIconADD[index] = true;
          p("bloc.readONLY", bloc.readONLY);
        //   setState(() {
        //     //compulsory
        //   }); //it shows keyboard then hidden immediately
        },
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            TextFormField(
              //todo con
              // onTap: onTapOutside(),
              focusNode: _node[index],
              // style:TextStyle(fontSize: sizeText.toDouble()), //size todo.content
              // style: Todo.getTextStyle(lineTHROUGH),

              // autofocus: !bloc.readONLY[index] ,//focus todoMe rồi mới focus chỉ todoCon đầu tiên (nếu todo mẹ và con đều autofocus)

              // autofocus:true,//toàn bộ đều nhãn xanh
              // textInputAction: TextInputAction.send,
              decoration: InputDecoration(
                  // contentPadding:const EdgeInsets.all(8),//not effect size TF

                  // border:const UnderlineInputBorder(borderSide: BorderSide.none),//bỏ thanh dưới

                  isDense: true, //hiện nguyên chữ not nửa chữ (bề dọc)
                  // constraints: const BoxConstraints.expand(height: 1000,),
                  // filled:true,
                  // counterStyle:TextStyle(fontSize:sizeText.toDouble(),

                  //textBaseline:TextBaseline.ideographic), //size label
                  label: Text("Note ${todo.id}"),
                  // isCollapsed: true,//bỏ đường gach chan//textfield nhỏ lại
                  ////false thi text ko bị chồng lên nhau (dãn ra) và slidable delete cũng to ra ko còn bị che khuất
                  hoverColor: const Color.fromARGB(255, 115, 175,
                      243) //màu của phần trang trí: label, hint...
                  ),
              onEditingComplete: () =>
                  // setState(() {//nó hiện cái cũ rồi mới hiện cái mới
                  // onEditingCOMPLETE(todo, _controllers[index], index)
                  TodoBLOC.nhapSTREAM.sink.add(UpdateTodoEVENT(
                      Todo(todo.id, _controllers[index].text),
                      index)) //lần update thứ 3 bị Not in inclusive range 0..1: 11
              // })
              ,
              // readOnly: bloc.readONLY[index],
              controller: _controllers[index],
            ),
            Visibility(
              // visible:!bloc.readONLY[index],
              visible: _showIconADD[index],
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  p("show iconADD !bloc.readONLY[index]",
                      !bloc.readONLY[index]);
                  DialogTODO().showDialogTODO(
                      index, context, _controllers[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    p("dispose _controllers", _controllers);
    // _prefs.storedSoCOT(soCOT);

    // focusNode.dispose();

    super.dispose();
    bloc.dispose();
    for (int i = 0; i < bloc.listTODO.length; i++) {
      _controllers[i].dispose();
      _node[i].dispose();
    }
  }
}
