import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;

  ChatScreen({required this.userId, required this.userName});

  @override
  State<StatefulWidget> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String currentUser;
  late String otherUser;
  late Stream<QuerySnapshot> messagesStream;

  final TextEditingController messageController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getUserInformation();
    messagesStream = firestore
        .collection('chats')
        .doc(_getChatId())
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  void getUserInformation() async {
    User? user = auth.currentUser;
    if (user != null) {
      currentUser = user.uid; // Current user ID
      otherUser = widget.userId; // Set the other user ID from the selected user
    } else {
      // Handle no signed-in user
    }
  }

  void _sendMessage(String text) {
    firestore.collection('chats').doc(_getChatId()).collection('messages').add({
      'text': text,
      'sender': currentUser,
      'timestamp': DateTime.now(),
    });
  }

  String _getChatId() {
    List<String> users = [currentUser, otherUser];
    users.sort();
    return users.join('_');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.userName}'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messagesStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                List<QueryDocumentSnapshot> messages = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> message = messages[index].data() as Map<String, dynamic>;
                    bool isCurrentUser = message['sender'] == currentUser;
                    return ListTile(
                      title: Text(
                        message['text'],
                        textAlign: isCurrentUser ? TextAlign.end : TextAlign.start,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      _sendMessage(messageController.text);
                      messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
