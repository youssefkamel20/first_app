import 'package:first_app/shared/components/components.dart';
import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class NewTasksScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(AppCubit.get(context).tasks[index]),
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
        itemCount: AppCubit.get(context).tasks.length,
    );
  }
}
