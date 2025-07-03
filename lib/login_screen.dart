import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
   final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: Container(
          width:300,
          child: Column(
            children: [
              SizedBox(height:11),
              TextField(
                controller:_emailController,
                decoration: InputDecoration(labelText: 'email',border: OutlineInputBorder(),),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'password',border: OutlineInputBorder(),),
              ),
                  SizedBox(height: 10,),
            
                   SizedBox(height: 10,),
              ElevatedButton(child:Text('Login'),onPressed: (){

               
                
              },)
            ],
          ),
        ),
      ),
    );
  }
}