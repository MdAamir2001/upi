import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class FinalQrPage extends StatelessWidget {
  final String qrData;
  final String bankName; // Add type annotation for bankName
  final String amount; // Add type annotation for amount
  final String upiId;

  const FinalQrPage({
    Key? key,
    required this.qrData,
    required this.bankName,
    required this.amount,
    required this.upiId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String upiId = '';
    String bankName = '';
    String amount = '';

    // Extracting UPI ID, bank name, and amount from the QR data
    List<String> qrParts = qrData.split('&');
    for (String part in qrParts) {
      if (part.startsWith('pa=')) {
        upiId = Uri.decodeComponent(part.substring(3));
      } else if (part.startsWith('pn=')) {
        bankName = Uri.decodeComponent(part.substring(3));
      } else if (part.startsWith('am=')) {
        amount = Uri.decodeComponent(part.substring(3));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Upi Id: $upiId',
              style: TextStyle(fontSize: 20.0),
            ), Text(
              'Bank Name: $bankName',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              'Amount: $amount',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                _showPaymentSuccessDialog(context);
              },
              child: Text('Complete Payment'),
            ),
          ],
        ),
      ),
    );
  }

  void _showPaymentSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Successful'),
          content: Text('Do you want to proceed with the UPI payment?'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                launchUPIPayment(upiId); // Launch UPI payment function
                Navigator.of(context).pop();
              },
              child: Text('Proceed'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void launchUPIPayment(String upiId) async {
    String url = 'upi://pay?pa=$upiId'; // UPI payment URL with the UPI ID

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
