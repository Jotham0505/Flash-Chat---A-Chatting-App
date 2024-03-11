import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.isMe,required this.sender, required this.text});
  final String sender;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Material(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            elevation: 5,
            color: isMe == true ? Colors.yellow : Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 8,left: 15,right: 15),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.white
                ),
              ),
            ),
          ),
          Text(
            sender,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black
            ),
          )
        ],
      ),
    );
  }
}