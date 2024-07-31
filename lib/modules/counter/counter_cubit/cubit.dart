import 'package:bloc/bloc.dart';
import 'package:first_app/modules/counter/counter_cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit() : super(CounterInitialState());

  static CounterCubit get(context) => BlocProvider.of(context);

  int counter = 0;

  void plus(){
    counter++;
    emit(PlusState());
  }

  void minus(){
    counter--;
    emit(MinusState());
  }

}