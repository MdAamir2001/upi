import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upi_1/sendmoney.dart';

import 'dashboard.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/Images/UD2.png'), // Replace with your image asset
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Money Sent Successfully',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                        (route) => false, // Clear the navigation stack
                  );
                  Provider.of<SendMoneyState>(context, listen: false).updateEnteredName('');
                  Provider.of<SendMoneyState>(context, listen: false).updateEnteredPhoneNumber('');
                  Provider.of<SendMoneyState>(context, listen: false).updateEnteredAmount(0.0);
                },
                child: Text('Back to Dashboard'),
              ),
              SizedBox(height: 10.0), // Add some space between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to the Send Money screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SendMoneyScreen(contactName: ''),
                    ),
                  );
                },
                child: Text('Pay Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
