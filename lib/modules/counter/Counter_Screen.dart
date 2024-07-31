import 'package:first_app/modules/counter/counter_cubit/cubit.dart';
import 'package:first_app/modules/counter/counter_cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget
 {
   

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state){},
        builder: (context, state){
          return Scaffold(
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).minus();
                    },
                    child: Text('Minus',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
                    child: Text('${CounterCubit.get(context).counter}',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      CounterCubit.get(context).plus();
                    },
                    child: Text('Plus',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20
                      ),
                    ),
                  ),
                ],
              ),
            ),

          );
        },
      ),
    );
  }
}
