import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageTextFieldController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User LoggedinUser;
  late String messageText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }


  void getCurrentUser() async{
    final user = _auth.currentUser;
    if (user!=null) {
      try {
        LoggedinUser = user;
      } catch (e) {
        print(e);
      }
      
    }
  }

  void messagesStream() async{
    await for(var snapshots in _firestore.collection('messages').snapshots()){
      for(var message in snapshots.docs){
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(onPressed: () async {
           // _auth.signOut();
            //Navigator.pop(context);
            messagesStream();
          },
          icon: const Icon(Icons.close)),
        ],
        title: const Text(
          'Chat',
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStream(firestore: _firestore, LoggedinUser: LoggedinUser),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: MessageTextFieldController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(onPressed:()async{
                    MessageTextFieldController.clear();
                   try {
                     final data = await _firestore.collection('messages').add({
                      'Text': messageText,
                      'Sender': LoggedinUser.email,
                    });
                   } catch (e) {
                     print(e);
                   }
                  },
                  child: const Text(
                    'Send',
                    style: kSendButtonTextStyle,
                  ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    super.key,
    required FirebaseFirestore firestore,
    required this.LoggedinUser,
  }) : _firestore = firestore;

  final FirebaseFirestore _firestore;
  final User LoggedinUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context,snapshots){
        List<Widget> messageBubbles = [];
        if (snapshots.hasData) {
          for(var message in snapshots.data!.docs){
            final messages = message.data();
            final messageText = messages['Text'];
            final messagSender = messages['Sender'];
            final currentUser = LoggedinUser?.email;
            if (currentUser == messagSender) {
              // the message is from the loggein User
            }
            MessageBubble messageBubble = MessageBubble(isMe: currentUser == messagSender, sender: messagSender, text: messageText);
            messageBubbles.add(messageBubble);
        } 
        }else{
          return const Center(
            child: Text('Hello'),
          );
        }
        return Expanded(
          child: ListView(
            children: messageBubbles,
          ),
        );
      }
      );
  }
}