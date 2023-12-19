import 'package:flutter/material.dart';
import 'package:upi_payment/qr_display.dart';

class QRGenerator extends StatelessWidget {
  final TextEditingController upiIdController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generate UPI QR'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: upiIdController,
              decoration: InputDecoration(
                labelText: 'Enter UPI ID',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Enter Amount',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                String upiId = upiIdController.text;
                String amount = amountController.text;

                if (upiId.isNotEmpty && amount.isNotEmpty) {
                  String paymentUrl = 'upi://pay?pa=$upiId&pn=Name&am=$amount';

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QRDisplayPage(
                        qrData: paymentUrl,
                        upiId: upiId,
                        amount: amount,
                      ),
                    ),
                  );
                } else {
                  // Show error if UPI ID or amount is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter UPI ID and amount'),
                    ),
                  );
                }
              },
              child: Text('Generate QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}