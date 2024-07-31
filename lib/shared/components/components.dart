import 'package:first_app/shared/components/constants.dart';
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

Widget buildTaskItem(Map model) => Padding(
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
                fontSize: 15,
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
    ],
  ),
);