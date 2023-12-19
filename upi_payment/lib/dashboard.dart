import 'package:flutter/material.dart';
import 'package:upi_payment/authenticate_screen.dart';
import 'package:upi_payment/phone_tab_example.dart';
import 'package:upi_payment/qr_generator.dart';
import 'package:upi_payment/sendmoney_screen.dart';
import 'qr_scan_screen.dart';

class Dashboard extends StatelessWidget {
  final String email;
  final String password;

  Dashboard({required this.email, required this.password});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              // Add logout functionality here
              // For example, navigate back to the login screen or perform logout logic
              Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()));
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text('$email'),
            Text('$password'),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Icons Below',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => QRGenerator()));

                              },
                              icon: Icon(Icons.qr_code_2),
                            ),
                            SizedBox(height: 8.0),
                            Text('QR Code'),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => SendMoneyScreen()));
                            }, icon: Icon(Icons.phone)),
                            Text('Mobile'),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(onPressed: () {}, icon: Icon(Icons.electric_bolt_outlined)),
                            Text('Electricity'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20), // Add space between cards
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Widget',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Find a number or UPI id to pay',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              // Implement search functionality here
                              print('Search query: $value');
                              // Perform search operation with the provided value
                            },
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // Action when search button is pressed
                            // For example, initiate search
                            print('Search button tapped');
                          },
                          icon: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Scrollable Icons',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          8, // Adjust the count of icons as needed
                              (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.blue, // Customize color as needed
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(
                                Icons.person, // Change icon as needed
                                color: Colors.white, // Customize icon color if necessary
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}