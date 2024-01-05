import 'package:flutter/material.dart';
import 'package:upi/sigin.dart';

import 'login.dart';
import 'main.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Images/UD2.png'), // Replace with the path to your background image asset
            fit: BoxFit.fill,
            // You can adjust the BoxFit as needed
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/Images/123.png', // Replace with the path to your image asset
              //   width: 150.0, // Adjust the width as needed
              //   height: 150.0, // Adjust the height as needed
              // ),
              // SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                child: Text('Sign In'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}