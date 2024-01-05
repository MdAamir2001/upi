import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'authenticate_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseOptions firebaseOptions = FirebaseOptions(
    apiKey: 'AIzaSyAKKEY3jwuOg-Mi5_QIGi-3JuDorfbn-vI',
    authDomain: 'upipayment-823f0.firebaseapp.com',
    projectId: 'upipayment-823f0',
    storageBucket: 'https://console.firebase.google.com/u/0/project/upipayment-823f0/storage/upipayment-823f0.appspot.com/files',
    messagingSenderId: '1057524534539',
    appId: '1:1057524534539:android:6be73a3e1b5f22c374260e',
  );
  await Firebase.initializeApp(options: firebaseOptions);
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
  Color _backgroundColor = Colors.blueGrey;
  bool _colorChanged = false;

  @override
  void initState() {
    super.initState();
    // Simulating color change after a delay of 3 seconds
    Timer(Duration(seconds: 2), () {
      setState(() {
        _backgroundColor = Colors.white54;
        _colorChanged = true;
        Timer(Duration(seconds: 2), () {
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
      backgroundColor: _backgroundColor,
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
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

