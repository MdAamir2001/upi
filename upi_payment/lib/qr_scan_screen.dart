// import 'package:flutter/material.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:upi_payment/qr_page.dart';
//
//
//
// class QRGenerator extends StatefulWidget {
//   @override
//   _QRGeneratorState createState() => _QRGeneratorState();
// }
//
// class _QRGeneratorState extends State<QRGenerator> {
//   TextEditingController textEditingController1 = TextEditingController();
//   TextEditingController textEditingController2 = TextEditingController();
//   TextEditingController textEditingController3 = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('QR Code Generator'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextField(
//               controller: textEditingController1,
//               decoration: InputDecoration(
//                 labelText: 'Enter Bank Name',
//               ),
//             ),
//             SizedBox(height: 20.0),
//             TextField(
//               controller: textEditingController2,
//               decoration: InputDecoration(
//                 labelText: 'Enter UPI Id',
//               ),
//             ),
//             SizedBox(height: 20.0),
//             TextField(
//               controller: textEditingController3,
//               decoration: InputDecoration(
//                 labelText: 'Enter Price',
//               ),
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () {
//                 String bankName = textEditingController1.text;
//                 String upiId = textEditingController2.text;
//                 String amount = textEditingController3.text;
//
//                 // Replace this URL with your payment URL format
//                 String paymentUrl = 'upi://pay?pa=$upiId&pn=$bankName&am=$amount';
//
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => QRPage(qrData: paymentUrl),
//                   ),
//                 );
//               },
//               child: Text('Generate QR Code'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
