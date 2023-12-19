import 'package:flutter/material.dart';
import 'sign_in_page.dart';
import 'sign_up_page.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  double _buttonWidth = 200.0;
  double _buttonHeight = 50.0;

  void _animateButton() {
    setState(() {
      _buttonWidth = 250.0;
      _buttonHeight = 60.0;
    });
    Future.delayed(Duration(milliseconds: 300), () {
      // Navigating to SignInPage after the animation completes
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    });
  }

  void _animateSignUpButton() {
    setState(() {
      _buttonWidth = 250.0;
      _buttonHeight = 60.0;
    });
    Future.delayed(Duration(milliseconds: 300), () {
      // Navigating to SignUpPage after the animation completes
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUpPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Sign In / Sign Up')),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Images/signin.jpg'), // Replace with your image asset
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _buttonWidth,
                height: _buttonHeight,
                child: ElevatedButton(
                  onPressed: _animateButton,
                  child: Text('Sign In'),
                ),
              ),
              SizedBox(height: 20.0),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _buttonWidth,
                height: _buttonHeight,
                child: ElevatedButton(
                  onPressed: _animateSignUpButton,
                  child: Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
