import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'Success.dart';
import 'amountscreen.dart';
import 'dashboard.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

void saveDataToDatabase(String name, String phoneNumber, double amount) async {
  final response = await http.post(
    Uri.parse('http://200411LTP2876:57648/app.js'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'phoneNumber': phoneNumber,
      'amount': amount,
    }),
  );

  if (response.statusCode == 200) {
    print('Data saved successfully');
  } else {
    print('Failed to save data');
  }
}

class SendMoneyState extends ChangeNotifier {
  String contactName = '';
  String enteredName = '';
  String enteredPhoneNumber = '';
  double enteredAmount = 0.0;

  // Method to update contactName
  void updateContactName(String newName) {
    contactName = newName;
    notifyListeners();
  }

  // Method to update enteredName
  void updateEnteredName(String newName) {
    enteredName = newName;
    notifyListeners();
  }

  // Method to update enteredPhoneNumber
  void updateEnteredPhoneNumber(String newPhoneNumber) {
    enteredPhoneNumber = newPhoneNumber;
    notifyListeners();
  }

  // Method to update enteredAmount
  void updateEnteredAmount(double newAmount) {
    enteredAmount = newAmount;
    notifyListeners();
  }
}

class SendMoneyScreen extends StatefulWidget {
  final String contactName;

  SendMoneyScreen({required this.contactName});

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Retrieve initial values from SendMoneyState
    _nameController.text = Provider.of<SendMoneyState>(context, listen: false).enteredName;
    _phoneNumberController.text = Provider.of<SendMoneyState>(context, listen: false).enteredPhoneNumber;
  }

  String? _validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validatePhoneNumber(String value) {
    // Define a regular expression for a valid phone number (10 digits)
    RegExp regex = RegExp(r'^[0-9]{10}$');

    if (value.isEmpty) {
      return 'Phone number is required';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }

    return null;
  }

  void _sendMoney(BuildContext context, double enteredAmount) {
    // Validate the name and phone number before sending money
    String name = _nameController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();

    String? nameError = _validateName(name);
    String? phoneNumberError = _validatePhoneNumber(phoneNumber);

    if (nameError != null || phoneNumberError != null) {
      // Show an alert message for validation errors
      _showAlert('Validation Error', [
        if (nameError != null) nameError,
        if (phoneNumberError != null) phoneNumberError,
      ]);
      return;
    }

    // Save data to the database
    saveDataToDatabase(name, phoneNumber, enteredAmount);

    // Add transaction to Hive
    addTransactionToHive(Transaction(amount: enteredAmount, userName: name));

    // Implement your sending money logic, such as making API calls or updating a database
    print('Sending $enteredAmount to $name ($phoneNumber)');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AmountEntryScreen(
          onAmountEntered: (amount) {
            Provider.of<SendMoneyState>(context, listen: false).updateEnteredAmount(amount);
            _sendMoney(context, amount);
          },
          enteredAmount: Provider.of<SendMoneyState>(context, listen: false).enteredAmount,
          contactName: '',
        ),
      ),
    );
  }

  void _showAlert(String title, List<String> messages) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            for (String message in messages) Text(message),
          ],
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  void addTransactionToHive(Transaction newTransaction) async {
    final _transactionBox = await Hive.openBox<Transaction>('transactionBox');

    // Add the new transaction to Hive
    await _transactionBox.add(newTransaction);

    // Close the Hive box
    await _transactionBox.close();
  }

  @override
  Widget build(BuildContext context) {
    final sendMoneyState = Provider.of<SendMoneyState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Send Money to ${sendMoneyState.contactName}'),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/Images/UD2.png'), // Replace with your image asset
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                onChanged: (value) {
                  sendMoneyState.updateEnteredName(value);
                },
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _phoneNumberController,
                onChanged: (value) {
                  sendMoneyState.updateEnteredPhoneNumber(value);
                },
                decoration: InputDecoration(labelText: 'Phone Number'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to AmountEntryScreen when the user clicks the button
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AmountEntryScreen(
                        onAmountEntered: (amount) {
                          sendMoneyState.updateEnteredAmount(amount);
                          _sendMoney(context, amount);
                        },
                        enteredAmount: sendMoneyState.enteredAmount,
                        contactName: '',
                      ),
                    ),
                  );
                },
                child: Text('Send Money'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
