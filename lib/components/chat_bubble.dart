import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key,required this.isCurrentUser,required this.message});
  final String message;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isCurrentUser ? Colors.green.shade600 : Colors.grey.shade600,
      ),
      child: Text(message,style: TextStyle(
        color: Theme.of(context).colorScheme.inversePrimary,
      ),),
    );
  }
}
