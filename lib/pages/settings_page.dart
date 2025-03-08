import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jay_chat_zone/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.inversePrimary
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text('Settings'),
          titleTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
          centerTitle: true,
        ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8)
        ),
        margin: EdgeInsets.all(25),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Darkmode",style: TextStyle(
              color:Theme.of(context).colorScheme.inversePrimary,
            ),),
            CupertinoSwitch(value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode, onChanged: (value) {
              Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
            },)
          ],
        ),
      ),
    );
  }
}
