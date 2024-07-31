import 'dart:math';

import 'package:first_app/modules/bmi_result/BMI_Result_Screen.dart';
import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  int intialWeight = 70;
  int minWeight = 30;
  int maxWeight = 140;
  int minAge = 10;
  int maxAge = 80;
  int intialAge = 22;
  bool isMale = false ;
  double height = 170;
  late double result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text('BMI Calculator',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[700],
        child: Column(
          children: [

            //Gender Navigation
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isMale = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: isMale? Colors.blue : Colors.grey,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.male,
                                size: 80,),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Male',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),)
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 20,
                    ),

                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isMale = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: !isMale? Colors.blue : Colors.grey,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.female,
                                size: 80,),
                              SizedBox(
                                height: 20,
                              ),
                              Text('Female',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Height Slider
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hight',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text('${height.round()}',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                            ),),
                          SizedBox(
                            width: 5,
                          ),
                          Text('cm',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      Slider(
                          value: height,
                          max: 230,
                          min: 140,
                          onChanged: (value){
                            setState(() {
                              height = value;
                            });
                          }),
                    ],
                  ),
                ),
              )
            ),

            // Age & Weight
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Age
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Age',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Text('$intialAge',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: 'age-' ,
                                  onPressed: (){
                                    setState(() {
                                      if(intialAge > minAge){
                                        intialAge--;
                                      }
                                    });
                                  },
                                  mini: true,
                                  shape: CircleBorder(),
                                  child: Icon(Icons.remove),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                FloatingActionButton(
                                  heroTag: 'age+',
                                  onPressed: (){
                                    setState(() {
                                      if(intialAge < maxAge) {
                                        intialAge++;
                                      }
                                    });
                                  },
                                  mini: true,
                                  shape: CircleBorder(),
                                  child: Icon(Icons.add),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),

                    SizedBox(width: 20,),

                    //Weight
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Weight',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Text('$intialWeight',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FloatingActionButton(
                                  heroTag: 'weight-',
                                  onPressed: (){
                                    setState(() {
                                      if(intialWeight > minWeight){
                                        intialWeight--;
                                      }
                                    });
                                  },
                                  mini: true,
                                  shape: CircleBorder(),
                                  child: Icon(Icons.remove),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                FloatingActionButton(
                                  heroTag: 'weight+',
                                  onPressed: (){
                                    setState(() {
                                      if(intialWeight < maxWeight){
                                        intialWeight++;
                                      }
                                    });
                                  },
                                  mini: true,
                                  shape: CircleBorder(),
                                  child: Icon(Icons.add),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Calculate button
            Container(
              width: double.infinity,
              height: 50,
              color: Colors.grey[900],
              child: MaterialButton(
                  onPressed: (){
                    result = intialWeight / pow(height/100, 2);
                    print(result);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BmiResultScreen(
                              result: result,
                              age: intialAge,
                              isMale: isMale,
                            ),)
                    );
                  },
                child: Text('Calculate',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
