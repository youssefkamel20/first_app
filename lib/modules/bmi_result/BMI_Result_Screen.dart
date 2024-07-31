import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {

  final double result ;
  final bool isMale;
  final int age;

BmiResultScreen({
  required this.result,
  required this.isMale,
  required this.age,
});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
      ),
      body: Container(
        color: Colors.grey[700],
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Your result is',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(40),
              child: Text('${result.round()}',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white
              ),),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green[500],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text('Your Gender is ${isMale? 'Male' : 'Female'}',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text('Your age is $age',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
