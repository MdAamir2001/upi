import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Login.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp( options: const FirebaseOptions(
  //   projectId: 'pushnotification-ed4ce',
  //   appId: '1:914466051541:android:0946569f31d976e561195c',
  //   apiKey: 'AIzaSyDc3yHcxrWJVwkmjreTznJbW9LnBDMqTjk',
  //   messagingSenderId: '914466051541',
  // ),);
  // await FirebaseApi().initNotification();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MobileNumberProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bill Payment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class MobileNumberProvider extends ChangeNotifier {
  late String _mobileNumber;

  String get mobileNumber => _mobileNumber;

  void setMobileNumber(String number) {
    _mobileNumber = number;
    notifyListeners();
  }
}

class InkWellCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  InkWellCard({required this.icon, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 150.0,
          height: 115.0,
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 50 , color: Colors.purpleAccent,),
              SizedBox(height: 10),
              Text(
                text,
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class IconTextButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  IconTextButton({required this.icon, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: 50),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}











