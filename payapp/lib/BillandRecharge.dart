import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:payapp/servicecard.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'mobileRecharge.dart';


class BillsAndRechargesPage extends StatefulWidget {
  @override
  _BillsAndRechargesPageState createState() => _BillsAndRechargesPageState();
}

class _BillsAndRechargesPageState extends State<BillsAndRechargesPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  List<ServiceCardData> services = [
    ServiceCardData('Electricity', '\$100', '2023-01-31'),
    ServiceCardData('Water Tax', '\$50', '2023-01-31'),
    ServiceCardData('Airtel', '\$30', '2023-01-31'),
    ServiceCardData('Gas Bill', '\$80', '2023-01-31'),
  ];

  String selectedService = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Payment'),
        backgroundColor: Colors.purple, // Darker shade of purple
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Theme(
          data: ThemeData(
            primaryColor: Colors.deepPurple, // Darker shade of purple
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.deepPurple, // Primary color
              accentColor: Colors.amber, // Accent color
            ),
            scaffoldBackgroundColor: Colors.grey[200], // Light grey background
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurpleAccent, // Accent color for buttons
                onPrimary: Colors.white, // Text color on buttons
                elevation: 5, // Button elevation
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select a Bill to Pay',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Display service cards
              Column(
                children: services.map((service) {
                  return ServiceCard(
                    service: service,
                    isSelected: selectedService == service.name,
                    onTap: () {
                      setState(() {
                        selectedService = service.name;
                      });
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement bill payment logic here
                  // You can use the selectedService and integrate with a payment gateway or service
                  // For a simple example, just print the details for now
                  if (selectedService.isNotEmpty) {
                    print(
                        'Processing payment of $selectedService for account ${accountNumberController.text}');
                  } else {
                    print('Please select a service before proceeding.');
                  }
                },
                child: Text('Pay Bill'),
              ),
              SizedBox(height: 40),
              // Section for "Bill and Recharges" with icons
              Text(
                'Bill and Recharges',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Row of four icons and text buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconTextButton(
                    icon: Icons.phone_android,
                    text: 'Mobile Recharge',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MobileRechargePage(),
                        ),
                      );
                    },
                  ),
                  IconTextButton(
                    icon: Icons.tv,
                    text: 'DTH TV',
                    onTap: () {
                      // Add functionality for DTH TV button here
                      print('DTH TV button pressed');
                    },
                  ),
                  IconTextButton(
                    icon: Icons.flash_on,
                    text: 'Electricity',
                    onTap: () {
                      // Add functionality for Electricity button here
                      print('Electricity button pressed');
                    },
                  ),
                  IconTextButton(
                    icon: Icons.directions_car,
                    text: 'FasTag',
                    onTap: () {
                      // Add functionality for FasTag button here
                      print('FasTag button pressed');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}