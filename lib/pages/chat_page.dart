import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jay_chat_zone/components/chat_bubble.dart';
import 'package:jay_chat_zone/components/my_textfield.dart';
import 'package:jay_chat_zone/services/auth/auth_service.dart';
import 'package:jay_chat_zone/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key,required this.receiverEmail,required this.receiverID});
  final String receiverEmail;
  final String receiverID;
  final TextEditingController _messageController= TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage()async{
    if(_messageController.text.isNotEmpty){
      await _chatService.sendMessage(receiverID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.inversePrimary
        ),
        title: Text(receiverEmail),
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(),
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList(){
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(stream: _chatService.getMessages(receiverID, senderID), builder: (context, snapshot) {
        if(snapshot.hasError){
          return const Text("Error");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Text("Loading...");
        }
        return ListView(
          children: snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String,dynamic> data = doc.data() as Map<String,dynamic>;
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment= isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(isCurrentUser: isCurrentUser, message: data["message"])
          ],
        ));
  }

  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Row(
        children: [
          Expanded(child: MyTextfield(
              hintText: "Type a message",
              obsecureText: false,
              controller: _messageController
          ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green.shade600,
              shape: BoxShape.circle
            ),
            margin: EdgeInsets.only(right: 25),
            child: IconButton(onPressed: () {
              sendMessage();
            }, icon: Icon(Icons.arrow_upward,color: Colors.white,)),
          )
        ],
      ),
    );
  }
}
