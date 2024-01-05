import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BillandRecharge.dart';
import 'main.dart';


class WelcomePage extends StatelessWidget {
  final String username;

  WelcomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $username!'),
        backgroundColor: Colors.purple, // Set the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Top Card with Welcome Message
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome,',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      username,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            // Fixed-sized Square Container for Four Cards
            Container(
              height: 270.0, // Set a fixed height for the container
              decoration: BoxDecoration(
                color: Colors.grey.shade200, // Set the container background color
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  // First Row with two cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWellCard(icon: Icons.qr_code, text: 'Scan QR Code'),
                      InkWellCard(icon: Icons.contacts, text: 'Pay Contacts'),
                    ],
                  ),
                  Divider(), // Divider between the rows
                  // Second Row with two cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWellCard(icon: Icons.phone, text: 'Pay Phone Number'),
                      // InkWellCard with navigation for "Pay Bills" card
                      InkWellCard(
                        icon: Icons.assignment,
                        text: 'Pay Bills',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BillsAndRechargesPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
