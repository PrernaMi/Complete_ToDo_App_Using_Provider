import 'package:complete_todo_provider_db/database/local/db_helper.dart';
import 'package:flutter/material.dart';

import '../models/notes_model.dart';

class TodoProvider extends ChangeNotifier{
  DbHelper? mainDb;
  TodoProvider({required this.mainDb});

  List<NotesModel> _allTask = [];
  double isComp = 0;

  void addInProvider({required NotesModel newNote,required int isCom})async{
    bool check = await mainDb!.addInDb(title: newNote.title, desc: newNote.desc,isComp : isCom);
    if(check){
      _allTask =await mainDb!.getAllNotesFromDb();
      notifyListeners();
    }
  }

  void updateProvider({required NotesModel updatedModel,required int s_no})async{
    bool check = await mainDb!.updateInDb(title: updatedModel.title, desc: updatedModel.desc, s_no: s_no);
    if(check){
      _allTask =await mainDb!.getAllNotesFromDb();
      notifyListeners();
    }
  }

  void deleteProvider({required int s_no})async{
    bool check = await mainDb!.deleteFromDb(s_no: s_no);
    if(check){
      _allTask = await mainDb!.getAllNotesFromDb();
      notifyListeners();
    }
  }

  void isComProvider({required int s_no,required int isCheck})async{
    bool check = await mainDb!.addIsCompleted(s_no: s_no, isCheck: isCheck);
    if(check){
      _allTask = await mainDb!.getAllNotesFromDb();
      notifyListeners();
    }
  }

  void getIsCompProvider()async{
    double value = await mainDb!.getIsCompleted();
    isComp = value;
    notifyListeners();
  }

  double retIsCom(){
    return isComp;
  }

  void getInitialNotes()async{
    _allTask = await mainDb!.getAllNotesFromDb();
    notifyListeners();
  }

  List<NotesModel> getTaskFromProvider(){
    return _allTask;
  }
}