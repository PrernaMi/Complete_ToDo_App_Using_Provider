import 'package:complete_todo_provider_db/database/local/db_helper.dart';
import 'package:complete_todo_provider_db/models/notes_model.dart';
import 'package:complete_todo_provider_db/provider/todo_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_update_task.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    context.read<TodoProvider>().getInitialNotes();
    context.read<TodoProvider>().getIsCompProvider();
    super.initState();
  }

  Icon icon = Icon(
    Icons.circle_outlined,
    size: 30,
  );

  @override
  Widget build(BuildContext context) {
    List<NotesModel> allNotes = [];
    double progress = 0;
    allNotes = context.watch<TodoProvider>().getTaskFromProvider();
    progress = context.watch<TodoProvider>().retIsCom();
    double pro = progress==0 ? 0 : progress;
    pro = pro/allNotes.length;
    pro = (pro*100).roundToDouble();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Home Page")),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //           begin: Alignment.topLeft,
            //           end: Alignment.bottomRight,
            //           colors: [Colors.blue, Colors.blue.shade200]),
            //       borderRadius: BorderRadius.circular(15)),
            //   height: 200,
            //   child: Padding(
            //       padding: EdgeInsets.all(20),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Expanded(
            //               flex: 1,
            //               child: Text(
            //                 "Today's progress summery",
            //                 style: TextStyle(color: Colors.white, fontSize: 23),
            //               )),
            //           /*-------Task Added-------*/
            //           Expanded(
            //               flex: 1,
            //               child: Text(
            //                 "${allNotes.length} Tasks",
            //                 style: TextStyle(color: Colors.white, fontSize: 16),
            //               )),
            //           SizedBox(
            //             height: 25,
            //           ),
            //           Expanded(
            //             flex: 2,
            //             child: Row(
            //               children: [
            //                 Expanded(
            //                   flex: 2,
            //                   child: Column(
            //                     mainAxisAlignment: MainAxisAlignment.start,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       SizedBox(
            //                         height: 15,
            //                       ),
            //                       Row(
            //                         children: [
            //                           Text(
            //                             "Progress",
            //                             style: TextStyle(color: Colors.white),
            //                           ),
            //                           SizedBox(
            //                             width: 50,
            //                           ),
            //                           Text("${pro}",
            //                             style: TextStyle(color: Colors.white),
            //                           )
            //                         ],
            //                       ),
            //                       Stack(
            //                         children: [
            //                           Container(
            //                             width: 140,
            //                             height: 10,
            //                             decoration: BoxDecoration(
            //                                 border: Border(
            //                                     top: BorderSide(
            //                                         color: Colors.grey.shade400,
            //                                         width: 7)),
            //                                 borderRadius:
            //                                     BorderRadius.circular(8)),
            //                           ),
            //                           SizedBox(height: 4,),
            //                           Container(
            //                             width: pro == 0 ? 0 : 140*pro/100 ,
            //                             height: 10,
            //                             decoration: BoxDecoration(
            //                                 border: Border(
            //                                     top: BorderSide(
            //                                         color: Colors.white70,
            //                                         width: 7)),
            //                                 borderRadius:
            //                                     BorderRadius.circular(8)),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //                 Expanded(
            //                   flex: 1,
            //                   child: Stack(
            //                     // children: [
            //                     //   ClipOval(
            //                     //       child: Image.asset(
            //                     //         "assets/images/img.png",
            //                     //         height: 40,
            //                     //         width: 40,
            //                     //       )),
            //                     //   Positioned(
            //                     //       left: 20,
            //                     //       child: ClipOval(
            //                     //           child: Image.asset(
            //                     //             "assets/images/img_1.png",
            //                     //             height: 40,
            //                     //             width: 40,
            //                     //           ))),
            //                     //   Positioned(
            //                     //       left: 40,
            //                     //       child: ClipOval(
            //                     //           child: Image.asset(
            //                     //             "assets/images/img_2.png",
            //                     //             height: 40,
            //                     //             width: 40,
            //                     //           ))),
            //                     //   Positioned(
            //                     //       left: 60,
            //                     //       child: ClipOval(
            //                     //           child: Image.asset(
            //                     //             "assets/images/img_3.png",
            //                     //             height: 40,
            //                     //             width: 40,
            //                     //           )))
            //                     // ],
            //                   ),
            //                 )
            //               ],
            //             ),
            //           )
            //         ],
            //       )),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's task",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "See all",
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 15),
                ),
              ],
            ),
            Expanded(
              child: allNotes.isNotEmpty
                  ? ListView.builder(
                      itemCount: allNotes.length,
                      itemBuilder: (_, Index) {
                        return ListTile(
                          leading: SizedBox(
                            width: 65,
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      if (allNotes[Index].isComp == 0) {
                                        context.read<TodoProvider>().isComProvider(
                                                s_no: allNotes[Index].s_no!,
                                                isCheck: 1);
                                        context.read<TodoProvider>().getIsCompProvider();
                                      } else {
                                        context
                                            .read<TodoProvider>()
                                            .isComProvider(
                                                s_no: allNotes[Index].s_no!,
                                                isCheck: 0);
                                        context.read<TodoProvider>().getIsCompProvider();
                                      }
                                    },
                                    child: allNotes[Index].isComp == 0
                                        ? Icon(
                                            Icons.circle_outlined,
                                            size: 30,
                                          )
                                        : Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 30,
                                          )),
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                        child: Text(
                                      '${Index + 1}',
                                      style: TextStyle(fontSize: 15),
                                    )))
                              ],
                            ),
                          ),
                          title: allNotes[Index].isComp == 1
                              ? Text(
                                  allNotes[Index].title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.lineThrough),
                                )
                              : Text(
                                  allNotes[Index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          subtitle: Text(allNotes[Index].desc),
                          trailing: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return AddUpdateScreen(
                                          flag: false,
                                          s_no: allNotes[Index].s_no,
                                          mTitle: allNotes[Index].title,
                                          mDesc: allNotes[Index].desc,
                                        );
                                      }));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                      size: 30,
                                    )),
                                InkWell(
                                  onTap: (){
                                    context.read<TodoProvider>().deleteProvider(s_no: allNotes[Index].s_no!);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  : Center(
                      child: Text(
                      "No Notes yet..",
                      style: TextStyle(fontSize: 25),
                    )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add task",
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddUpdateScreen(
              flag: true,
            );
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
