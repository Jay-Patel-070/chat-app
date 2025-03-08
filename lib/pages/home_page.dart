import 'package:flutter/material.dart';
import 'package:jay_chat_zone/components/my_drawer.dart';
import 'package:jay_chat_zone/pages/chat_page.dart';
import 'package:jay_chat_zone/services/auth/auth_service.dart';
import 'package:jay_chat_zone/services/chat/chat_service.dart';
import 'package:jay_chat_zone/components/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Chat Zone'),
        titleTextStyle: TextStyle(
          color:Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }
  Widget _buildUserList(){
    return StreamBuilder(stream: _chatService.getUserStream(), builder: (context, snapshot){
        if(snapshot.hasError){
          return const Text('Error');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text('Loading...');
        }
        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(userData,context)).toList(),
        );
      },
    );
  }
  Widget _buildUserListItem(Map<String,dynamic> userData, BuildContext context){
    if(userData["email"] != _authService.getCurrentUser()!.email){
    return UserTile(text: userData["email"], onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(receiverEmail: userData["email"],receiverID: userData["uid"],),));
    },);}
    else{
      return Container();
    }
  }
}

