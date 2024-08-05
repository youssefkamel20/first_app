import 'package:first_app/layout/news_app/news_layout.dart';
import 'package:first_app/modules/login/Login_Screen.dart';
import 'package:first_app/shared/bloc_observer.dart';
import 'package:first_app/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
          appBarTheme: AppBarTheme(
          actionsIconTheme: IconThemeData(
            size: 35
          ),
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        ),
      /*darkTheme: ThemeData(
        scaffoldBackgroundColor: HexColor('4C2A56'),
        appBarTheme: AppBarTheme(
          backgroundColor: HexColor('4C2A56'),
          actionsIconTheme: IconThemeData(
            color: Colors.white,
              size: 35
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor('4C2A56'),
            statusBarIconBrightness: Brightness.light,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),*/
      home: NewsLayout(),
    );
  }

}