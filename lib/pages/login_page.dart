import 'package:flutter/material.dart';
import 'package:jay_chat_zone/services/auth/auth_service.dart';
import 'package:jay_chat_zone/components/my_button.dart';
import 'package:jay_chat_zone/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key,required this.onTap});
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  void Function()? onTap;

  void login(BuildContext context)async{
    final authService = AuthService();
    try{
      await authService.signInWithEmailPassword(_emailController.text, _pwController.text);
    }catch(e){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ),
      );
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
            SizedBox(height: 25,),
            MyButton(
              text: 'Login',
              onTap: () => login(context),
            ),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Not a Member? ',style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                GestureDetector(onTap: onTap,child: Text('Register Now',style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
