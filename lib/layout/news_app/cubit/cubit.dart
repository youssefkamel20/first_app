import 'package:first_app/layout/news_app/cubit/states.dart';
import 'package:first_app/modules/news_modules/business/business.dart';
import 'package:first_app/modules/news_modules/science/science.dart';
import 'package:first_app/modules/news_modules/sports/sports.dart';
import 'package:first_app/modules/settings/settings_screen.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<MoltenTab> bottomItems = [
    MoltenTab(
      icon: Icon(Icons.business),
      title: Text(
        'business',
        style: TextStyle(
          color: Colors.grey[200],
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    ),
    MoltenTab(
      icon: Icon(Icons.sports),
      title: Text(
        'sports',
        style: TextStyle(
          color: Colors.grey[200],
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    ),
    MoltenTab(
      icon: Icon(Icons.science),
      title: Text(
        'science',
        style: TextStyle(
          color: Colors.grey[200],
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    ),
    MoltenTab(
      icon: Icon(Icons.settings),
      title: Text(
        'settings',
        style: TextStyle(
          color: Colors.grey[200],
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    ),
  ];
  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen()
  ];
  void changeBottomNavBar(index) {
    currentIndex = index;
    if(index == 1) {
      getSports();
    } else if(index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        }).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('error is catched $error');
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'sports',
            'apiKey': '715589baf4b44fc4b9237aea2372b8be',
          }).then((value) {
        sports = value.data['articles'];
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print('error is catched $error');
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsGetScienceLoadingState());

    if(science.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'science',
            'apiKey': '715589baf4b44fc4b9237aea2372b8be',
          }).then((value) {
        science = value.data['articles'];
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print('error is catched $error');
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }
}
