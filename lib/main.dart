import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'registration_screen.dart';
import 'task_screen.dart';

void main() {
  runApp(TaskyApp());
}

class TaskyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      theme: ThemeData(
      primarySwatch: Colors.indigo,),
      home: WelcomeScreen(),
      routes: {
        '/register': (context) => RegistrationScreen(),
        '/tasks': (context) => TaskScreen(userName: '',),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'lib/assets/cover.jpg', 
                height: 200,
              ),
              SizedBox(height: 20),
 
            RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold,),
                  children: [
                    TextSpan(
                      text: 'Welcome to ',
                      style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Tasky!',
                      style: TextStyle(color: Colors.indigo[900],fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),
              Text(
                'Manage all your projects and tasks in one place.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
               child: Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,  backgroundColor:Colors.indigo[900],
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                  textStyle: TextStyle(fontSize: 16,color:Colors.white, )
                ),
              ),
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color:const Color.fromARGB(255, 121, 119, 119),fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: 'Sign in',
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {             
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

