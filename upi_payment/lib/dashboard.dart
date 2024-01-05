import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upi_payment/authenticate_screen.dart';
import 'package:upi_payment/qr_generator.dart';
import 'package:upi_payment/sendmoney_screen.dart';

import 'chat_screen.dart';

class Dashboard extends StatefulWidget {
  final String email;
  final String password;
  final FirebaseAuth auth;

  Dashboard({required this.email, required this.password, required this.auth});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? additionalDetails;

  final TextEditingController _additionalDetailsController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _navigateToChat(String selectedUserName) async {
    User? currentUser = widget.auth.currentUser;

    if (currentUser != null) {
      // Get the current user's ID and pass it along with the selected username
      String currentUserId = currentUser.uid;

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(userId: currentUserId, userName: selectedUserName),
        ),
      );
    }
  }
  // Future<void> _navigateToChatScreen(String userId, String userName) async {
  //   // Navigate to the ChatScreen while passing the user ID and name
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ChatScreen(userId: userId, userName: userName),
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('${widget.email}'),
            const SizedBox(height: 10),
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Icons Below',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => QRGenerator()));
                          },
                          icon: Icon(Icons.qr_code_2),
                        ),
                        SizedBox(height: 8.0),
                        Text('QR Code'),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            try {
                              User? currentUser = _auth.currentUser;
                              QuerySnapshot usersSnapshot = await _firestore.collection('users').get();

                              List<String> userNames = usersSnapshot.docs.map((doc) {
                                Map<String, dynamic>? userData = doc.data() as Map<String, dynamic>?;

                                if (userData != null && userData.containsKey('username')) {
                                  return userData['username'] as String;
                                } else {
                                  return ''; // Handle the case where 'username' is null or not present
                                }
                              }).toList();


                              if (currentUser != null) {
                                // Get the username of the current logged-in user
                                String currentUserName = (await _firestore.collection('users').doc(currentUser.uid).get()).data()?['username'];
                                userNames.remove(currentUserName); // Remove the current user's username from the list
                              }

                              userNames.sort(); // Sort the usernames alphabetically

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Users'),
                                    content: SizedBox(
                                      height: 300, // Adjust height to fit your content
                                      width: 300, // Adjust width to fit your content
                                      child: // Inside the showDialog builder
                                      ListView.builder(
                                        itemCount: userNames.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          return ListTile(
                                            title: GestureDetector(
                                              onTap: () {
                                                String selectedUserName = userNames[index];
                                                _navigateToChat(selectedUserName); // Navigate to chat with selected username
                                              },
                                              child: Text(userNames[index]),
                                            ),
                                          );
                                        },
                                      ),

                                    ),
                                  );
                                },
                              );
                            } catch (e) {
                              print('Error fetching users: $e');
                            }
                          },
                          icon: Icon(Icons.phone),
                        ),
                        Text('Mobile'),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {},
                            icon: Icon(Icons.electric_bolt_outlined)),
                        Text('Electricity'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10), // Add space between cards
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search Widget',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Find a number or UPI id to pay',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // Implement search functionality here
                          print('Search query: $value');
                          // Perform search operation with the provided value
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Action when search button is pressed
                        // For example, initiate search
                        print('Search button tapped');
                      },
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10, ),
            TextFormField(
              controller: _additionalDetailsController,
              decoration: InputDecoration(
                hintText: 'Enter your additional details here',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                print('Additional details: $value');
                _updateAdditionalDetails(value);
              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                _retrieveAdditionalDetails();
              },
              child: Text('Retrieve Additional Details'),
            ),
            SizedBox(height: 10),

            if (additionalDetails != null)
              Text(
                'Additional Details: $additionalDetails',
                style: TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateAdditionalDetails(String value) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'additionalDetails': value,
        });
        print('Additional details updated in Firestore: $value');
      } else {
        print('No signed-in user found.');
      }
    } catch (e) {
      print('Error updating additional details: $e');
    }
  }

  Future<void> _retrieveAdditionalDetails() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await _firestore.collection('users').doc(user.uid).get();
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('additionalDetails')) {
          setState(() {
            additionalDetails = data['additionalDetails'];
          });
        }
      } else {
        print('No signed-in user found.');
      }
    } catch (e) {
      print('Error retrieving additional details: $e');
    }
  }
}

