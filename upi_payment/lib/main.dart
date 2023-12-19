import 'package:flutter/material.dart';
import 'dart:async';

import 'authenticate_screen.dart';

void main() {
  runApp(UPISplashScreen());
}

class UPISplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UPI Payments',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Color _backgroundColor = Colors.blue; // Initial background color
  bool _colorChanged = false; // Flag to control color change

  @override
  void initState() {
    super.initState();
    // Simulating color change after a delay of 3 seconds
    Timer(Duration(seconds: 3), () {
      setState(() {
        _backgroundColor = Colors.white30; // Change to desired color
        _colorChanged = true; // Update flag

        // Navigate to the next page after 4 seconds
        Timer(Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AuthScreen()),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor, // Use the dynamic background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/Images/logo1.png",width: 50,height: 50,),
            SizedBox(height: 20),
            Text(
              'UPI Payments',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // if (_colorChanged)
            //   Text(
            //     'Background Color Changed!',
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 18,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}

