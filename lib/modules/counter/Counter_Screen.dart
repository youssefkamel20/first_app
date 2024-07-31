import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget
{
  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                setState(() {
                  counter--;
                });
              },
              child: Text('Minus',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20
              ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 15),
              child: Text('$counter',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold
              ),
              ),
            ),
            TextButton(
              onPressed: (){
                setState(() {
                  counter++;
                });
              },
              child: Text('Plus',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}
