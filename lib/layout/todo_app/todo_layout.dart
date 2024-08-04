import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates states) {
          if(states is AppInsertDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppStates states) {
          AppCubit cubit = AppCubit.get(context);

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
                      child: Text(
                        cubit.titels[cubit.currentIndex],
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
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
                        child: cubit.screens[cubit.currentIndex]),
                  ),
                ],
              ),
            ),

            //BottomSheet for adding new tasks
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isButtomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                    );
                  };
                } else {
                  cubit.changeBottomSheetState(
                    icon: Icons.add,
                    isShow: true,
                  );
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) {
                          return Container(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(30)),
                                color: Colors.grey[800]),
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
                                    onTap: () {
                                      showTimePicker(
                                              context: context,
                                              initialTime:
                                                  TimeOfDay(hour: 0, minute: 0))
                                          .then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
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
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2022),
                                        lastDate: DateTime(2025),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
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
                          );
                        },).closed.then((value) {
                        cubit.changeBottomSheetState(
                            icon: Icons.edit,
                            isShow: false,
                        );
                      });
                }
              },
              child: Icon(cubit.fabIcon),
              shape: CircleBorder(),
            ),

            //navigationBar to toggle between screens
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentIndex,
              iconSize: 30,
              backgroundColor: Colors.grey[900],
              unselectedFontSize: 0,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.white,
              showUnselectedLabels: false,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                      //color: Colors.red,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
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

            /* bottomNavigationBar: CurvedNavigationBar(
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
        },
      ),
    );
  }
}
