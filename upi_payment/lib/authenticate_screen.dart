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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/Images/bank.jpg', width: 100, height: 100,),
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Images/UPI.png'),
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
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCustomIconButton(Icons.mail_outline_outlined, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      }),
                      _buildCustomIconButton(Icons.facebook_outlined, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      }),
                      _buildCustomIconButton(Icons.camera_alt, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      }),
                      _buildCustomIconButton(Icons.apple_rounded, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                IconButton(
                  icon: Icon(Icons.copyright_rounded),
                  onPressed: () {
                    // Add functionality for copyright button
                  },
                ),
                Text(
                  'Since 2023',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20.0,
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

Widget _buildCustomIconButton(IconData icon, VoidCallback onPressed) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blueGrey, // Change to your desired background color
      borderRadius: BorderRadius.circular(8.0),
    ),
    padding: EdgeInsets.all(8.0),
    child: IconButton(
      icon: Icon(
        icon,
        size: 30, // Change the icon size as needed
        color: Colors.white, // Change the icon color as needed
      ),
      onPressed: onPressed,
    ),
  );
}
