import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'operatorDetails.dart';


class MobileRechargePage extends StatelessWidget {
  final List<Operator> operators = loadOperators();
  final TextEditingController mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Recharge'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: mobileNumberController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Enter Mobile Number',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),
              // Bold Text - Mobile Operators
              Text(
                'Mobile Operators',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              // List of Tappable Mobile Operators
              // Inside the Column widget where you display operators
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: operators.map((operator) {
                  return InkWell(
                    onTap: () {
                      context.read<MobileNumberProvider>().setMobileNumber(mobileNumberController.text);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OperatorDetailsPage(
                            operator: operator,
                            mobileNumber: mobileNumberController.text,
                            selectedPlans: [],
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(operator.iconPath),
                      ),
                      title: Text(operator.name),
                      subtitle: Text(
                        'Type: ${operator.type}',
                        style: TextStyle(color: Colors.grey[600]), // Set subtitle text color
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print('Processing mobile recharge for number entered');
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black26, // Set button background color
                ),
                child: Text('Recharge Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
