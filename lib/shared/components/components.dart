import 'package:first_app/shared/components/constants.dart';
import 'package:first_app/shared/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  required Color? backGroundColor ,
  required String text,
  required function,
})=> Container(
  decoration: BoxDecoration(
    color: backGroundColor,
    borderRadius: BorderRadius.all(Radius.circular(20)),
  ),
  child: MaterialButton(
      child: Text('${text.toUpperCase()}',
      style: TextStyle(
        color: Colors.black,
      ),),
      onPressed: function,
      ),
);

Widget defaultFormField({
  required controller,
  required type,
  required String labelText,
  required String validationText,
  bool obsecureText = false,
  required IconData prefix,
  Widget? suffixIcon,
  var labelStyle,
  Color? prefixIconColor,
  var onTap,
}) => TextFormField(
  validator: (value){
    if(value!.isEmpty){
      return '$validationText must not be Empty';
    }
    return null;
  },
  controller: controller,
  keyboardType: type,
  onTap: onTap,
  obscureText: obsecureText,
  style: TextStyle(color: prefixIconColor),
  decoration: InputDecoration(
      prefixIcon: Icon(prefix),
      prefixIconColor: prefixIconColor,
      suffixIcon: suffixIcon,
      labelText: labelText,
      labelStyle: TextStyle(color: prefixIconColor,),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
  ),

);

Widget buildTaskItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
  child: Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('${model['time']}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${model['title']}',
                maxLines: 2,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('${model['date']}',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(status: 'done', id: model['id']);
            },
            icon: Icon(Icons.check_box,
            color: Colors.green,)
        ),
        IconButton(
            onPressed: () {
              AppCubit.get(context).updateData(status: 'archived', id: model['id']);
            },
            icon: Icon(Icons.archive,
            color: Colors.grey,),
        ),
      ],
    ),
  ),
);

Widget myDivider() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
  child: Container(
    height: 1,
    width: double.infinity,
    color: Colors.grey[400],
  ),
);

Widget buildArticleItem(article) =>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey,
          // image: DecorationImage(
          //     image: NetworkImage('${article['urlToImage'] == null? 'https://www.elbalad.news/UploadCache/libfiles/1066/7/600x338o/460.png' : article['urlToImage']} '),
          //     fit: BoxFit.cover
          // ),
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text('${article['title']}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),),
              ),
              Text('${article['publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
) ;