import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

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

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login / Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate login credentials (add your authentication logic)
                // For simplicity, assume login is successful
                String username = usernameController.text;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomePage(username: username),
                  ),
                );
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  final String username;

  WelcomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $username!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Top Card with Welcome Message
            Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Welcome,',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      username,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            // Fixed-sized Square Container for Four Cards
            Container(
              height: 270.0, // Set a fixed height for the container
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: <Widget>[
                  // First Row with two cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWellCard(icon: Icons.qr_code, text: 'Scan QR Code'),
                      InkWellCard(icon: Icons.contacts, text: 'Pay Contacts'),
                    ],
                  ),
                  Divider(), // Divider between the rows
                  // Second Row with two cards
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWellCard(icon: Icons.phone, text: 'Pay Phone Number'),
                      // InkWellCard with navigation for "Pay Bills" card
                      InkWellCard(
                        icon: Icons.assignment,
                        text: 'Pay Bills',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BillsAndRechargesPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
          width: 150.0, // Set a fixed width for the container
          height: 115.0, // Set a fixed height for the container
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 50),
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

// New Page for Bills and Recharges
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  print('Processing payment of $selectedService for account ${accountNumberController.text}');
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
                IconTextButton(icon: Icons.phone_android, text: 'Mobile Recharge', onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MobileRechargePage(),
                    ),
                  );
                }),
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
    );
  }
}

class ServiceCardData {
  final String name;
  final String billedAmount;
  final String dueDate;

  ServiceCardData(this.name, this.billedAmount, this.dueDate);
}

class ServiceCard extends StatelessWidget {
  final ServiceCardData service;
  final bool isSelected;
  final VoidCallback onTap;

  ServiceCard({
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: isSelected ? Colors.blue : null,
      child: ListTile(
        title: Text(
          service.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.white : null),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Amount: ${service.billedAmount}'),
            Text('Due Date: ${service.dueDate}'),
          ],
        ),
        onTap: onTap,
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

class MobileRechargePage extends StatelessWidget {
  final List<Operator> operators = loadOperators();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Recharge'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Mobile Number Entry Field with India Flag Icon
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.search), // You can replace this with your desired search icon
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter Mobile Number',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),
              // Bold Text - Mobile Operators
              Text(
                'Mobile Operators',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              // List of Tappable Mobile Operators
              // Inside the Column widget where you display operators
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: operators.map((operator) {
                  return InkWell(
                    onTap: () {
                      // Navigate to another page when an operator is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OperatorDetailsPage(operator: operator),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        //child: Image.asset(operator.iconPath),
                        backgroundImage: AssetImage(operator.iconPath),
                      ),
                      title: Text(operator.name),
                      subtitle: Text('Type: ${operator.type}'),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {

                  print('Processing mobile recharge for number entered');
                },
                child: Text('Recharge Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OperatorDetailsPage extends StatelessWidget {
  final Operator operator;

  OperatorDetailsPage({required this.operator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Operator Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Operator: ${operator.name}'),
            Text('Type: ${operator.type}'),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}


class Operator {
  final String name;
  final String type;
  final String iconPath;

  Operator({required this.name, required this.type, required this.iconPath});
}


List<Operator> loadOperators() {

  String jsonString = '''
  [
    {"name": "Jio prepaid", "type": "Prepaid", "iconPath": "assets/images/jio_icon.png"},
    {"name": "Airtel prepaid", "type": "Prepaid", "iconPath": "assets/images/airtel_icon.png"},
    {"name": "Vi prepaid", "type": "Prepaid", "iconPath": "assets/images/vi_icon.png"},
    {"name": "BSNL prepaid", "type": "Prepaid", "iconPath": "assets/images/bsnl_icon.png"},
    {"name": "MTNL Delhi prepaid", "type": "Prepaid", "iconPath": "assets/images/mtnl_icon.png"}
  ]
  ''';

  List<dynamic> jsonList = json.decode(jsonString);
  List<Operator> operators = [];

  for (var json in jsonList) {
    operators.add(Operator(
      name: json['name'],
      type: json['type'],
      iconPath: json['iconPath'],
    ));
  }

  return operators;
}



