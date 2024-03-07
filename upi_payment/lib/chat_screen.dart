import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chatbot',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessages(),
          ),
          BottomAppBar(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child:
                        MessageInputField(), // Separate widget for input field
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('messages')
          .orderBy('timestamp')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var message = snapshot.data!.docs[index];
              return ListTile(
                title: Text(message['content']),
                subtitle: Text(message['sender']),
              );
            },
          );
        }
      },
    );
  }
}

class MessageInputField extends StatefulWidget {
  @override
  _MessageInputFieldState createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() async {
    String messageText = _messageController.text.trim();
    if (messageText.isNotEmpty) {
      // Get the current user (sender)
      String senderId = FirebaseAuth.instance.currentUser!.uid;

      // Assuming you have a receiver ID for demonstration purposes
      String receiverId =
          'receiverUserId'; // Replace this with actual receiver ID

      // Create a timestamp for the message
      Timestamp timestamp = Timestamp.now();

      // Store the message in the sender's database
      FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .collection('messages')
          .add({
        'content': messageText,
        'sender': senderId,
        'receiver': receiverId,
        'timestamp': timestamp,
      });

      // Store the message in the receiver's database
      FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('messages')
          .add({
        'content': messageText,
        'sender': senderId,
        'receiver': receiverId,
        'timestamp': timestamp,
      });

      // Clear the text field after sending the message
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: _messageController,
        decoration: InputDecoration(
          hintText: 'Type a message...',
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
        ),
        // Implement sending messages to Firestore on form submission
        onFieldSubmitted: (value) {
          _sendMessage();
        },
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Chatbot App',
    home: ChatScreen(),
  ));
}
