
import 'package:first_app/layout/home_layout.dart';
import 'package:first_app/modules/bmi/BMI_Screen.dart';
import 'package:first_app/modules/login/Login_Screen.dart';
import 'package:first_app/modules/messenger/Messenger_Screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeLayout(),
    );
  }

}