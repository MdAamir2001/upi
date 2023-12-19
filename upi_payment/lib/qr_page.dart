import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:upi_payment/final_qe_page.dart';


class QRPage extends StatelessWidget {
  final String qrData;

  const QRPage({Key? key, required this.qrData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String upiId = '';
    String bankName = '';
    String amount = '';

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

    String finalQrData = 'pa=$upiId&pn=$bankName&am=$amount';

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              // Generate QR code based on the final data
              data: finalQrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FinalQrPage(
                      qrData: finalQrData,
                      bankName: bankName,
                      amount: amount,
                      upiId: upiId,
                    ),
                  ),
                );
              },
              child: Text('Complete Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
