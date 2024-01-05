import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class QRDisplayPage extends StatelessWidget {
  final String qrData;
  final String upiId;
  final String amount;

  const QRDisplayPage({
    Key? key,
    required this.qrData,
    required this.upiId,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR for Payment'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white30, Colors.blueGrey],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200.0,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _launchUPIPayment(qrData);
                },
                child: Text('Scan QR for Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _launchUPIPayment(String url) async {

    await launch(url);
    // if (await canLaunch(url)) {
    //
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

}