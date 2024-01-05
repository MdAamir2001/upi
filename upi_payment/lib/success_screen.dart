import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SuccessScreen extends StatelessWidget {
  final String phoneNumber;

  SuccessScreen({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            SizedBox(height: 20),
            Text(
              'Money Sent Successfully!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SendMoneyScreen(prefilledNumber: phoneNumber),
                  ),
                );
              },
              child: Text('Pay Again'),
            ),
          ],
        ),
      ),
    );
  }
}

class SendMoneyScreen extends StatefulWidget {
  final String? prefilledNumber;

  SendMoneyScreen({this.prefilledNumber});

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: widget.prefilledNumber ?? '');
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  void sendMoney() {
    // Implement your send money logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Money'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only accepts numbers
              ],
              decoration: InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                } else if (value.length != 10) {
                  return 'Phone number should be 10 digits';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: sendMoney,
              child: Text('Send Money'),
            ),
          ],
        ),
      ),
    );
  }
}
