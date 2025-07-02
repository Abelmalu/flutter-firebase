import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Center(
        child: Container(
          width:300,
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'email',border: OutlineInputBorder(),),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(labelText: 'password',border: OutlineInputBorder(),),
              ),
                  SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(labelText: 'confirmpassword',border: OutlineInputBorder(),),
              ),
                  SizedBox(height: 10,),
              ElevatedButton(child:Text('sign up'),onPressed: (){
                
              },)
            ],
          ),
        ),
      ),
    );
  }
}
