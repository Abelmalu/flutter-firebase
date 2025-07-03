import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notesapp/login_screen.dart';
import 'firebase_options.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
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
              TextField(
                controller: _passwordConfirmationController,
                decoration: InputDecoration(labelText: 'confirmpassword',border: OutlineInputBorder(),),
              ),

              SizedBox(height: 10,),
              InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder:(context)=>SignInScreen()));


              },child: Text('SignIn here'),),
             
                   SizedBox(height: 10,),
              ElevatedButton(child:Text('sign up'),onPressed: (){

                _singUp();
                
              },)
            ],
          ),
        ),
      ),
    );
  }

  void _singUp() async{

    _isLoading = true;
    _errorMessage = null;

    try{

      UserCredential userCrdential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:_emailController.text.trim(),
        password: _passwordController.text.trim()
      );

      print('user created ${userCrdential}');
    }on FirebaseAuthException catch (e) {
    setState(() {
      _errorMessage = "${e.code} - ${e.message}";
    });
    print("Error: $_errorMessage");
  } 
    


  }
}
