import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'operatorDetails.dart';


class PaymentSuccessfulPage extends StatelessWidget {
  final String mobileNumber;
  final List<Plan> selectedPlans;

  PaymentSuccessfulPage({
    required this.mobileNumber,
    required this.selectedPlans,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Payment Successful'),
          backgroundColor: Colors.purple
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white60, Colors.grey],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(101.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Mobile Number: $mobileNumber', style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showPaymentDetails(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text('Show Payment Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPaymentDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.greenAccent, Colors.green],
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 30,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Payment Successful',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Mobile Number: $mobileNumber', style: TextStyle(color: Colors.white)),
                SizedBox(height: 20),
                Text('Selected Plans:', style: TextStyle(color: Colors.white)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: selectedPlans.map((plan) {
                    return Text('${plan.name} - Amount: ${plan.amount.toStringAsFixed(2)}', style: TextStyle(color: Colors.white));
                  }).toList(),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  child: Text('OK', style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
