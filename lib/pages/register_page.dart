import 'package:flutter/material.dart';
import 'package:jay_chat_zone/services/auth/auth_service.dart';
import 'package:jay_chat_zone/components/my_button.dart';
import 'package:jay_chat_zone/components/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key,required this.onTap});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmpwController = TextEditingController();
  final void Function()? onTap;
  void register(BuildContext context){
    final _auth = AuthService();
    if(_pwController.text == _confirmpwController.text){
      try{
        _auth.signUpWithEmailPassword(_emailController.text, _pwController.text);
      }catch(e){
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
        );
      }
    }
    else{
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("Passwords don't match!"),
      ),);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to Jay Chat Zone',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 30
              ),
            ),
            SizedBox(height: 25,),
            MyTextfield(
              hintText: 'Email',
              obsecureText: false,
              controller: _emailController,
            ),
            SizedBox(height: 10,),
            MyTextfield(
              hintText: 'Password',
              obsecureText: true,
              controller: _pwController,
            ),
            SizedBox(height: 10,),
            MyTextfield(
              hintText: 'Confirm Password',
              obsecureText: true,
              controller: _confirmpwController,
            ),
            SizedBox(height: 25,),
            MyButton(
              text: 'register',
              onTap: () => register(context),
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? ',style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                GestureDetector(onTap: onTap,child: Text('Login now',style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),)),
              ],
            )
          ],
        ),
      ),
    );;
  }
}
