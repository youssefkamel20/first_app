import 'package:bloc/bloc.dart';
import 'package:first_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:first_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:first_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];
  List<String> titels = [
    'Tasks',
    'Done',
    'Archived'
  ];
  int currentIndex = 0;
  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  late Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('Database is created');
      database
          .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
          .then((value) {
        print('table is created');
      }).catchError((error) {
        print('Error is catched on creation of table ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }


  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")')
          .then((value) {
        print('$value inserted succefully');

        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);

      }).catchError((error) {
        print('Found error while inserting ${error.toString()}');
      });
    });
  }


  getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    database.rawQuery('SELECT * FROM tasks').then((value) {

      value.forEach((element){
        if(element['status'] == 'new'){
          newTasks.add(element);
        } else if (element['status'] == 'done'){
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
        emit(AppGetDatabaseState());
      });

    });
  }

  void updateData({
    required String status,
    required int id,
}) {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', '$id',]).then((value) {
          getDataFromDatabase(database);
          emit(AppUpdateDatabaseState());
        });
  }

  void deleteData({
    required int id,
  }) {
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }


  bool isButtomSheetShown = false;
  IconData fabIcon = Icons.edit;
  void changeBottomSheetState({
    required IconData icon,
    required bool isShow,
  }){
    isButtomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeButtomSheetState());
  }

}
