import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SendMoneyScreen extends StatefulWidget {
  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void sendMoney() {
    // Add logic here to send money to the entered phone number with the given amount
    String phoneNumber = phoneController.text;
    double amount = double.tryParse(amountController.text) ?? 0.0;

    // Implement the payment functionality or call your backend to initiate the transaction
    print('Sending $amount to $phoneNumber');
    // Add your payment service or backend integration here
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
                }
                // You can add more validation logic here if needed
                return null;
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount';
                }
                // You can add more validation logic here if needed
                return null;
              },
            ),
            SizedBox(height: 24.0),
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
