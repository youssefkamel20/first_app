import 'package:first_app/layout/news_app/cubit/cubit.dart';
import 'package:first_app/layout/news_app/cubit/states.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';


class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()..getBusiness(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = NewsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.brightness_4_outlined,),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],

            bottomNavigationBar: MoltenBottomNavigationBar(
              domeHeight: 25,
              barColor: Colors.grey[900],
              domeCircleColor: Colors.grey[700],
              curve: Curves.linear,
              selectedIndex: cubit.currentIndex,
              onTabChange: (index){
                cubit.changeBottomNavBar(index);
              },
              tabs: cubit.bottomItems,
            ),
          );
        },

      ),
    );
  }
}
