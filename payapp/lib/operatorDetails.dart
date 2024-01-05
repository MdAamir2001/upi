import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:payapp/paymentSuccessful.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class OperatorDetailsPage extends StatefulWidget {
  final Operator operator;
  final String mobileNumber;
  final List<Plan> selectedPlans;

  OperatorDetailsPage({
    required this.operator,
    required this.mobileNumber,
    required this.selectedPlans,
  });

  @override
  _OperatorDetailsPageState createState() => _OperatorDetailsPageState();
}

class _OperatorDetailsPageState extends State<OperatorDetailsPage> {
  late List<Plan> plans;
  late List<bool> selectedPlans;

  @override
  void initState() {
    super.initState();
    plans = loadPlans(widget.operator);
    selectedPlans = List.generate(plans.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    String mobileNumber =
        context.read<MobileNumberProvider>().mobileNumber;
    return Scaffold(
      appBar: AppBar(
        title: Text('Operator Details'),
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Operator: ${widget.operator.name}', style: TextStyle(color: Colors.white)),
              Text('Type: ${widget.operator.type}', style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.purple],
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Available Plans:', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: plans.map((plan) {
                        return ListTile(
                          title: Text(plan.name, style: TextStyle(color: Colors.white)),
                          subtitle: Text('Amount: ${plan.amount.toStringAsFixed(2)}', style: TextStyle(color: Colors.white)),
                          trailing: Checkbox(
                            value: selectedPlans[plans.indexOf(plan)],
                            onChanged: (value) {
                              setState(() {
                                selectedPlans[plans.indexOf(plan)] = value!;
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  List<Plan> selectedPlansList = [];
                  for (int i = 0; i < selectedPlans.length; i++) {
                    if (selectedPlans[i]) {
                      selectedPlansList.add(plans[i]);
                    }
                  }

                  if (selectedPlansList.isNotEmpty) {
                    print('Processing payment for selected plans: $selectedPlansList');

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentSuccessfulPage(
                          mobileNumber: widget.mobileNumber,
                          selectedPlans: selectedPlansList,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select at least one plan.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                ),
                child: Text('Pay Recharge', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Plan {
  final String name;
  final double amount;

  Plan({required this.name, required this.amount});
}

List<Plan> loadPlans(Operator operator) {

  return [
    Plan(name: 'Plan 1', amount: 100.0),
    Plan(name: 'Plan 2', amount: 200.0),
    Plan(name: 'Plan 3', amount: 300.0),

  ];
}

class Operator {
  final String name;
  final String type;
  final String iconPath;

  Operator({required this.name, required this.type, required this.iconPath});
}

List<Operator> loadOperators() {
  String jsonString = '''
  [
    {"name": "Jio prepaid", "type": "Prepaid", "iconPath": "assets/images/jio_icon.png"},
    {"name": "Airtel prepaid", "type": "Prepaid", "iconPath": "assets/images/airtel_icon.png"},
    {"name": "Vi prepaid", "type": "Prepaid", "iconPath": "assets/images/vi_icon.png"},
    {"name": "BSNL prepaid", "type": "Prepaid", "iconPath": "assets/images/bsnl_icon.png"},
    {"name": "MTNL Delhi prepaid", "type": "Prepaid", "iconPath": "assets/images/mtnl_icon.png"}
  ]
  ''';

  List<dynamic> jsonList = json.decode(jsonString);
  List<Operator> operators = [];

  for (var json in jsonList) {
    operators.add(Operator(
      name: json['name'],
      type: json['type'],
      iconPath: json['iconPath'],
    ));
  }

  return operators;
}