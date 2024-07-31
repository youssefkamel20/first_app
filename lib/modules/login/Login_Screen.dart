import 'package:first_app/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailControler = TextEditingController();
  var passwordControler = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool passwordSecured = true;
  var suffixIcon = Icons.remove_red_eye;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Text containing Login Screen
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: const Text('Login Screen',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Email must not be Empty';
                      }
                      return null;
                    },
                    controller: emailControler,
                    keyboardType: TextInputType.emailAddress,
                    // onFieldSubmitted: (String value){
                    //   print(value);
                    // },
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.alternate_email
                      ),
                      labelText: 'Email Adress',
                      border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Password must not be Empty';
                      }
                      return null;
                    },
                    controller: passwordControler,
                    obscureText: passwordSecured,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordSecured = !passwordSecured;
                              });
                            },
                            icon: passwordSecured? Icon(Icons.visibility_off) : Icon(Icons.visibility),
                        ),
                        labelText: 'Password',
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      defaultButton(
                          backGroundColor: Colors.blue,
                          function: (){
                            if(formKey.currentState!.validate()){
                              print(emailControler.text);
                              print(passwordControler.text);
                            }
                            return null;
                          },
                          text: 'Login',
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),

                      ),
                      TextButton(
                          onPressed: (){},
                          child: Text('Register',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),)
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
