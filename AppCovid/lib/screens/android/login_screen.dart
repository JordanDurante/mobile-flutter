import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/android/dashboard.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Login'),
      ),
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Dashboard() 
            ));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
          child: Text(
            'Login',
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      ),
    );
  }
}