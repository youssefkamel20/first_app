import 'package:flutter/material.dart';

class UserModel{
  final int id ;
  final String name;
  final String phone;

  UserModel(
  this.id,
  this.name,
  this.phone);
}

class UserScreen extends StatelessWidget{

  List<UserModel> users = [
    UserModel(1, 'Youssef Kamel', '+201206020955'),
    UserModel(2, 'Anton Kamel', '+201206513955'),
    UserModel(3, 'Ibrahim Kamel', '+2012061516421'),
    UserModel(4, 'Samia Kamel', '+201206154665'),
    UserModel(5, 'Kamel Ibrahim', '+201206546516'),
    UserModel(1, 'Youssef Kamel', '+201206020955'),
    UserModel(2, 'Anton Kamel', '+201206513955'),
    UserModel(3, 'Ibrahim Kamel', '+2012061516421'),
    UserModel(4, 'Samia Kamel', '+201206154665'),
    UserModel(5, 'Kamel Ibrahim', '+201206546516'),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Users',
        style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Colors.blue,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => buildUserItem(users[index]),
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            color: Colors.grey,
            height: 1,
          ),
          itemCount: users.length,
      ),
    );
  }

  Widget buildUserItem(UserModel user) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 25,
          child: Text('${user.id}',
            style: TextStyle(
                color: Colors.white,
                fontSize: 25
            ),),
          backgroundColor:Colors.blue,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${user.name}',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),),
              Text('${user.phone}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),),
            ],
          ),
        ),
      ],
    ),
  );

}