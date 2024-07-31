import 'package:first_app/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:first_app/modules/done_tasks/done_tasks_screen.dart';
import 'package:first_app/modules/new_tasks/new_tasks_screen.dart';
import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';


class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {

  int currentIndex = 0;
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
  late Database database;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  bool isButtomSheetShown = false;

  IconData fabIcon = Icons.edit;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,

      body: Container(
        color: Colors.grey[900],
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              //height: 80,
              width: double.infinity,
              color: Colors.grey[900],
              child: Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 40,
                  bottom: 15,
                  start: 20,
                  end: 15,
                ),
                child: Text(titels[currentIndex],
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),),
              ),
            ),
            Expanded(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                    child: tasks.length ==0? Center(child: CircularProgressIndicator()) : screens[currentIndex]),
            ),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          if(isButtomSheetShown){
            insertToDatabase(
              title: titleController.text,
              time: timeController.text,
              date: dateController.text,
            ).then((value){

              if(formKey.currentState!.validate()){
                getDataFromDatabase(database).then((value){
                  Navigator.pop(context);

                  setState(() {
                    isButtomSheetShown = false;
                    print(Database);
                    fabIcon = Icons.edit;
                    tasks = value;
                  });
                });
              }
            });
          }else{
            isButtomSheetShown = true;
            setState(() {
              fabIcon = Icons.add;
            });
            scaffoldKey.currentState!.showBottomSheet(
              (context) => Container(
                padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 20
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)
                  ),
                  color: Colors.grey[800]
                ),

                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Task Title form Field
                      defaultFormField(
                          controller: titleController,
                          type: TextInputType.text,
                          labelText: 'Task Title',
                          validationText: 'title',
                          prefixIconColor: Colors.white,
                          prefix: Icons.title,
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      //Task Time formfield
                      defaultFormField(
                        controller: timeController,
                        type: TextInputType.datetime,
                        onTap: (){
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay(hour: 0, minute: 0)
                            ).then((value){
                              timeController.text = value!.format(context).toString();
                            });
                        },
                        labelText: 'Task Time',
                        validationText: 'time',
                        prefixIconColor: Colors.white,
                        prefix: Icons.timer_sharp,
                      ),


                      SizedBox(
                        height: 15,
                      ),

                      //Task Date FormField
                      defaultFormField(
                        controller: dateController,
                        type: TextInputType.datetime,
                        onTap: (){
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2025),
                          ).then((value){
                            dateController.text = DateFormat.yMMMd().format(value!);
                          });
                        },
                        labelText: 'Task Date',
                        validationText: 'time',
                        prefixIconColor: Colors.white,
                        prefix: Icons.calendar_today,
                      ),
                    ],
                  ),
                ),
              ),
            ).closed.then((value){
              isButtomSheetShown = false;
              print(Database);
              setState(() {
                fabIcon = Icons.edit;
              });
            });
          }


        },
        child: Icon(fabIcon),
        shape: CircleBorder(),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        iconSize: 30,
        backgroundColor: Colors.grey[900],
        unselectedFontSize: 0,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        showUnselectedLabels: false,

        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                //color: Colors.red,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
                child: Icon(Icons.menu),
            ),
            key: Key('Tasks'),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            key: Key('Done'),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            key: Key('archived'),
            label: 'Archived',
          ),
        ],
      ),
      /*bottomNavigationBar: CurvedNavigationBar(
        color: Colors.black12,
        buttonBackgroundColor: Colors.black12,
        backgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
          },
          items: [
            Column(
              children: [
                Icon(Icons.menu),
                Text('Tasks'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.done),
                Text('Done'),
              ],
            ),
            Column(
              children: [
                Icon(Icons.archive_outlined),
                Text('Archieved'),
              ],
            ),
          ],
      ),*/
      /*bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: Colors.grey[700],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[900],
        snakeViewColor: Colors.grey[900],
        behaviour: SnakeBarBehaviour.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),

        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            key: Key('Tasks'),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline),
            key: Key('Done'),
            label: 'Done',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive_outlined),
            key: Key('archived'),
            label: 'Archived',
          ),
        ],
      ),*/
    );
  }

  void createDatabase()async {
    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('Database is created');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)').then((value){
          print('table is created');
        }).catchError((error){
          print('Error is catched on creation of table ${error.toString()}');
        });
      },
      onOpen: (database)
      {
        getDataFromDatabase(database).then((value){
          tasks = value;
        });
        print('${tasks.length}');
      },
    );
}

  Future insertToDatabase({
    required String title,
    required String time,
    required String date,

}) async {
    return await database.transaction((txn) {
      return txn.rawInsert(
        'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$time", "$date", "new")'
      )
        .then((value) {
          print('$value inserted succefully');
        }).catchError((error)
      {
        print('Found error while inserting ${error.toString()}');
      });
    });
  }

   getDataFromDatabase(database) async
  {
    return tasks = await database.rawQuery('SELECT * FROM tasks');
  }

}
