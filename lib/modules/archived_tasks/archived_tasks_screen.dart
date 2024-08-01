import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:first_app/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class ArchivedTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state){},
      builder: (context, AppStates states) {
        List<Map> tasks = AppCubit.get(context).archivedTasks;

        return tasks.length == 0
            ? Center(
            child: Text(
              'There are no archived tasks',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ))
            :ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
          separatorBuilder: (context, version) => Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 30,
              vertical: 10,
            ),
            child: Container(
              height: 1,
              width: double.infinity,
              color: Colors.grey[200],
            ),
          ),
          itemCount: tasks.length,
        );
      },
    );
  }
}
