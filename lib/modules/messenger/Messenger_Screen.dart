import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MessengerScreen extends StatelessWidget{
  var userImage = NetworkImage('https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp');

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: userImage,
              radius: 25,
            ),
            SizedBox(
              width: 15,
            ),
            Text('Chats',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),),
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){

              },
              icon: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: Colors.white,
                ),
              ),
          ),
          IconButton(
              onPressed: (){

              },
              icon: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.edit,
                  size: 20,
                  color: Colors.white,
                ),
              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.grey[300],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.search)),
                      //TextFormField(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  child: ListView.separated(
                      itemBuilder: (context, index) => buildStoryItem(),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => SizedBox(width: 15,),
                      itemCount: 7,
                  ),
                ),
              ) ,
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(
                  ),
                  itemBuilder: (context, index) =>buildChatItem(),
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  //padding: EdgeInsets.all(10),
                  itemCount: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget buildChatItem() => Row(
    children: [
      Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children:[
            CircleAvatar(
                backgroundImage: userImage),
            CircleAvatar(
              radius: 7,
              backgroundColor: Colors.green,
            )
          ]
      ),
      SizedBox(width: 20,),
      Expanded(
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User 1'),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: Text('How are you wating for you to call back, have a nice time wz the family',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                  child: Text('02:23 am'),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
  Widget buildStoryItem() => Container(
    width: 60,
    child: Column(
      children: [
        Stack(
            alignment: AlignmentDirectional.bottomEnd ,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage('https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp'),
                radius: 30,
              ),
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 7,
              ),
            ]
        ),
        Text('Youssef Kamel Ibrahim',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,),
      ],
    ),
  );
}