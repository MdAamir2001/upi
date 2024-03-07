import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:upi_payment/authenticate_screen.dart';
import 'package:upi_payment/qr_generator.dart';

import 'chat_screen.dart';

class Dashboard extends StatefulWidget {
  final String email;
  final String password;
  final FirebaseAuth auth;

  Dashboard({required this.email, required this.password, required this.auth});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  void _navigateToChat(String selectedUserName) {
    // Assuming ChatScreen takes a username as a parameter to start the chat
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatScreen()),
    );
  }

  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;
  late Animation<double> _cardAnimation;

  String? additionalDetails;
  final TextEditingController _additionalDetailsController =
      TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _fadeInAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _cardAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image with blur effect
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Images/chakra.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5), // Adjust opacity as needed
            ),
          ),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Dashboard'),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.orange.shade800,
                  Colors.white,
                  Colors.green.shade600
                ],
              ),
            ),
            child: FadeTransition(
              opacity: _fadeInAnimation,
              child: Padding(
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
                    const SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: _cardAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _cardAnimation.value,
                          child: Card(
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
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QRGenerator()));
                                          },
                                          icon: Icon(Icons.qr_code_2),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QRGenerator()));
                                            },
                                            child: Text('QR Code')),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () async {
                                                try {
                                                  User? currentUser =
                                                      _auth.currentUser;
                                                  QuerySnapshot usersSnapshot =
                                                      await _firestore
                                                          .collection('users')
                                                          .get();

                                                  List<String> userNames =
                                                      usersSnapshot.docs
                                                          .map((doc) {
                                                    Map<String, dynamic>?
                                                        userData = doc.data()
                                                            as Map<String,
                                                                dynamic>?;

                                                    if (userData != null &&
                                                        userData.containsKey(
                                                            'username')) {
                                                      return userData[
                                                          'username'] as String;
                                                    } else {
                                                      return '';
                                                    }
                                                  }).toList();

                                                  if (currentUser != null) {
                                                    String currentUserName =
                                                        (await _firestore
                                                                .collection(
                                                                    'users')
                                                                .doc(currentUser
                                                                    .uid)
                                                                .get())
                                                            .data()?['username'];
                                                    userNames.remove(
                                                        currentUserName);
                                                  }

                                                  userNames.sort();

                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Users'),
                                                        content: SizedBox(
                                                          height: 300,
                                                          width: 300,
                                                          child:
                                                              ListView.builder(
                                                            itemCount: userNames
                                                                .length,
                                                            itemBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    int index) {
                                                              return ListTile(
                                                                title:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    String
                                                                        selectedUserName =
                                                                        userNames[
                                                                            index];
                                                                    _navigateToChat(
                                                                        selectedUserName);
                                                                  },
                                                                  child: Text(
                                                                      userNames[
                                                                          index]),
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                } catch (e) {
                                                  print(
                                                      'Error fetching users: $e');
                                                }
                                              },
                                              icon: Icon(Icons.phone),
                                            ),
                                            TextButton(
                                                onPressed: () async {
                                                  try {
                                                    User? currentUser =
                                                        _auth.currentUser;
                                                    QuerySnapshot
                                                        usersSnapshot =
                                                        await _firestore
                                                            .collection('users')
                                                            .get();

                                                    List<String> userNames =
                                                        usersSnapshot.docs
                                                            .map((doc) {
                                                      Map<String, dynamic>?
                                                          userData = doc.data()
                                                              as Map<String,
                                                                  dynamic>?;

                                                      if (userData != null &&
                                                          userData.containsKey(
                                                              'username')) {
                                                        return userData[
                                                                'username']
                                                            as String;
                                                      } else {
                                                        return '';
                                                      }
                                                    }).toList();

                                                    if (currentUser != null) {
                                                      String currentUserName =
                                                          (await _firestore
                                                                  .collection(
                                                                      'users')
                                                                  .doc(
                                                                      currentUser
                                                                          .uid)
                                                                  .get())
                                                              .data()?['username'];
                                                      userNames.remove(
                                                          currentUserName);
                                                    }

                                                    userNames.sort();

                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          title: Text('Users'),
                                                          content: SizedBox(
                                                            height: 300,
                                                            width: 300,
                                                            child: ListView
                                                                .builder(
                                                              itemCount:
                                                                  userNames
                                                                      .length,
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                return ListTile(
                                                                  title:
                                                                      GestureDetector(
                                                                    onTap: () {
                                                                      String
                                                                          selectedUserName =
                                                                          userNames[
                                                                              index];
                                                                      _navigateToChat(
                                                                          selectedUserName);
                                                                    },
                                                                    child: Text(
                                                                        userNames[
                                                                            index]),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } catch (e) {
                                                    print(
                                                        'Error fetching users: $e');
                                                  }
                                                },
                                                child: Text('Mobile')),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.electric_bolt_outlined),
                                            ),
                                            Text('Electricity'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    AnimatedBuilder(
                      animation: _cardAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _cardAnimation.value,
                          child: Card(
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
                                            hintText:
                                                'Find a number or UPI id to pay',
                                            prefixIcon: Icon(Icons.search),
                                            border: OutlineInputBorder(),
                                          ),
                                          onChanged: (value) {
                                            print('Search query: $value');
                                          },
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
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
                        );
                      },
                    ),
                    const SizedBox(height: 20),
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
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        _retrieveAdditionalDetails();
                      },
                      child: Text('Retrieve Additional Details'),
                    ),
                    const SizedBox(height: 10),
                    if (additionalDetails != null)
                      Text(
                        'Additional Details: $additionalDetails',
                        style: TextStyle(fontSize: 16),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Remaining methods...

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
        DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
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
