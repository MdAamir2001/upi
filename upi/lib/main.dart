import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:upi/sendmoney.dart';

import 'package:upi/welcome.dart';
import 'package:upi/data_service.dart';

void main() async {

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SendMoneyState()),
        // Add other providers if needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
