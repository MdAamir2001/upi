import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upi/Success.dart';

class AmountEntryScreen extends StatefulWidget {
  final Function(double) onAmountEntered;
  final double? enteredAmount; // Make enteredAmount nullable

  AmountEntryScreen({required this.onAmountEntered, this.enteredAmount, required String contactName});

  @override
  _AmountEntryScreenState createState() => _AmountEntryScreenState();
}

class _AmountEntryScreenState extends State<AmountEntryScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial value if enteredAmount is not null
    if (widget.enteredAmount != null) {
      _amountController.text = widget.enteredAmount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Amount'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Images/UD2.png'), // Replace with your image asset
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  double? enteredAmount = double.tryParse(_amountController.text);
                  if (enteredAmount != null) {
                    widget.onAmountEntered(enteredAmount);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessScreen()));
                  } else {
                    // Handle invalid input or show an error message
                    _showErrorDialog();
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter a valid numeric amount.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
