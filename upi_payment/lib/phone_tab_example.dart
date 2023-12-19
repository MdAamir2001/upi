import 'package:flutter/material.dart';
import 'package:upi_payment/dashboard.dart';

class PhoneTabExample extends StatefulWidget {
  @override
  _PhoneTabExampleState createState() => _PhoneTabExampleState();
}

class _PhoneTabExampleState extends State<PhoneTabExample> {
  String _currentTab = 'Home'; // Variable to control the displayed tab

  void _changeTab(String tab) {
    setState(() {
      _currentTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget tabContent;
    if (_currentTab == 'Home') {
      tabContent = Center(child: Text('Home Tab'));
    } else if (_currentTab == 'Phone') {
      tabContent = Center(child: Text('Phone Tab'));
    } else {
      tabContent = Center(child: Text('Unknown Tab'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Tab Example'),
      ),
      body: tabContent,
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(email:AutofillHints.email, password: AutofillHints.password)));
              // Change to Home Tab
            },
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.phone),
          ),
        ],
      ),
    );
  }
}
