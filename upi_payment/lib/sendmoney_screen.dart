// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:upi_payment/success_screen.dart';
// import 'package:upi_payment/dashboard.dart';
//
// class SendMoneyScreen extends StatefulWidget {
//   final String email;
//   final String password;
//
//   SendMoneyScreen({required this.email, required this.password});
//
//   @override
//   _SendMoneyScreenState createState() => _SendMoneyScreenState();
// }
//
// class _SendMoneyScreenState extends State<SendMoneyScreen> {
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController amountController = TextEditingController();
//
//   @override
//   void dispose() {
//     phoneController.dispose();
//     amountController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Fetch phone number data from the database
//     fetchPhoneNumber();
//   }
//
//   void fetchPhoneNumber() async {
//     try {
//       // Retrieve the phone number data from Firestore (replace 'users' and 'user_id' with your actual collection and document IDs)
//       DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('users').doc('user.uid').get();
//
//       // Get the 'phoneNumber' field from the snapshot data
//       String? phoneNumber = snapshot.data()?['phoneNumber'];
//
//       // Set the retrieved phone number in the controller if it exists
//       if (phoneNumber != null) {
//         phoneController.text = phoneNumber;
//       }
//     } catch (e) {
//       print('Error fetching phone number: $e');
//     }
//   }
//
//   void sendMoney() {
//     // Implement your send money logic here
//     String phoneNumber = phoneController.text;
//     double amount = double.tryParse(amountController.text) ?? 0.0;
//
//     // Print for demonstration
//     print('Sending $amount to $phoneNumber');
//
//     // Mimicking a successful money sending operation
//     // Replace this with your actual logic
//     Future.delayed(Duration(seconds: 2), () {
//       // After a successful transaction, navigate to the success page
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => SuccessScreen(phoneNumber: phoneNumber)),
//       );
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.of(context).popUntil((route) => route.isFirst);
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Dashboard(email: widget.email, password: widget.password, auth: ,),
//           ),
//         );
//         return false; // Prevents the default back button behavior
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Send Money'),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 controller: phoneController,
//                 keyboardType: TextInputType.phone,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), // Only accepts numbers
//                 ],
//                 decoration: InputDecoration(
//                   labelText: 'Phone Number',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a phone number';
//                   } else if (value.length != 10) {
//                     return 'Phone number should be 10 digits';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 controller: amountController,
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 decoration: InputDecoration(
//                   labelText: 'Amount',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an amount';
//                   }
//                   // You can add more validation logic here if needed
//                   return null;
//                 },
//               ),
//               SizedBox(height: 24.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (phoneController.text.length == 10) {
//                     sendMoney();
//                   } else {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text('Error'),
//                           content: Text('Phone number should be 10 digits.'),
//                           actions: <Widget>[
//                             TextButton(
//                               onPressed: () {
//                                 Navigator.of(context).pop();
//                               },
//                               child: Text('OK'),
//                             ),
//                           ],
//                         );
//                       },
//                     );
//                   }
//                 },
//                 child: Text('Send Money'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
