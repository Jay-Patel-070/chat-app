import 'package:flutter/material.dart';
import 'package:jay_chat_zone/services/auth/auth_service.dart';
import 'package:jay_chat_zone/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});
  void logout(){
    final _auth = AuthService();
    _auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          SizedBox(height: 100,),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("C H A T  Z O N E",style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
              leading: Icon(Icons.home,color: Theme.of(context).colorScheme.inversePrimary,size: 25,),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("S E T T I N G S",style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
              leading: Icon(Icons.settings,color: Theme.of(context).colorScheme.inversePrimary,size: 25,),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(),));
              },
            ),
          ),
          SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("L O G O U T",style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
              leading: Icon(Icons.logout,color: Theme.of(context).colorScheme.inversePrimary,size: 25,),
              onTap: logout,
            ),
          )
        ],
      ),
    );
  }
}
