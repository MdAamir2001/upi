
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';




class MobileNumberProvider extends ChangeNotifier {

late String _mobileNumber;

String get mobileNumber => _mobileNumber;

void setMobileNumber(String number) {

_mobileNumber = number;

notifyListeners();

}

}


class InkWellCard extends StatelessWidget {

final IconData icon;

final String text;

final VoidCallback? onTap;

InkWellCard({required this.icon, required this.text, this.onTap});

@override

Widget build(BuildContext context) {

return Card(

elevation: 10,

child: InkWell(

onTap: onTap,

child: Container(

width: 150.0,

height: 115.0,

padding: EdgeInsets.all(8.0),

child: Column(

mainAxisAlignment: MainAxisAlignment.center,

children: <Widget>[

Icon(icon, size: 50),

SizedBox(height: 10),

Text(

text,

style: TextStyle(fontSize: 15),

textAlign: TextAlign.center,

),

],

),

),

),

);

}

}

// New Page for Bills and Recharges

class BillsAndRechargesPage extends StatefulWidget {

@override

_BillsAndRechargesPageState createState() => _BillsAndRechargesPageState();

}

class _BillsAndRechargesPageState extends State<BillsAndRechargesPage> {

TextEditingController amountController = TextEditingController();

TextEditingController accountNumberController = TextEditingController();

List<ServiceCardData> services = [

ServiceCardData('Electricity', '\$100', '2023-01-31'),

ServiceCardData('Water Tax', '\$50', '2023-01-31'),

ServiceCardData('Airtel', '\$30', '2023-01-31'),

ServiceCardData('Gas Bill', '\$80', '2023-01-31'),

];

String selectedService = '';

@override

Widget build(BuildContext context) {

return Scaffold(

appBar: AppBar(

title: Text('Bill Payment'),

),

body: Padding(

padding: const EdgeInsets.all(16.0),

child: Column(

crossAxisAlignment: CrossAxisAlignment.start,

children: <Widget>[

Text(

'Select a Bill to Pay',

style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

),

SizedBox(height: 20),

// Display service cards

Column(

children: services.map((service) {

return ServiceCard(

service: service,

isSelected: selectedService == service.name,

onTap: () {

setState(() {

selectedService = service.name;

});

},

);

}).toList(),

),

SizedBox(height: 20),

ElevatedButton(

onPressed: () {

// Implement bill payment logic here

// You can use the selectedService and integrate with a payment gateway or service

// For a simple example, just print the details for now

if (selectedService.isNotEmpty) {

print('Processing payment of $selectedService for account ${accountNumberController.text}');

} else {

print('Please select a service before proceeding.');

}

},

child: Text('Pay Bill'),

),

SizedBox(height: 40),

// Section for "Bill and Recharges" with icons

Text(

'Bill and Recharges',

style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

),

SizedBox(height: 20),

// Row of four icons and text buttons

Row(

mainAxisAlignment: MainAxisAlignment.spaceEvenly,

children: [

IconTextButton(icon: Icons.phone_android, text: 'Mobile Recharge', onTap: () {

Navigator.push(

context,

MaterialPageRoute(

builder: (context) => MobileRechargePage(),

),

);

}),

IconTextButton(

icon: Icons.tv,

text: 'DTH TV',

onTap: () {

// Add functionality for DTH TV button here

print('DTH TV button pressed');

},

),

IconTextButton(

icon: Icons.flash_on,

text: 'Electricity',

onTap: () {

// Add functionality for Electricity button here

print('Electricity button pressed');

},

),

IconTextButton(

icon: Icons.directions_car,

text: 'FasTag',

onTap: () {

// Add functionality for FasTag button here

print('FasTag button pressed');

},

),

],

),

],

),

),

);

}

}

class ServiceCardData {

final String name;

final String billedAmount;

final String dueDate;

ServiceCardData(this.name, this.billedAmount, this.dueDate);

}

class ServiceCard extends StatelessWidget {

final ServiceCardData service;

final bool isSelected;

final VoidCallback onTap;

ServiceCard({

required this.service,

required this.isSelected,

required this.onTap,

});

@override

Widget build(BuildContext context) {

return Card(

color: isSelected ? Colors.blue : null,

child: ListTile(

title: Text(

service.name,

style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? Colors.white : null),

),

subtitle: Column(

crossAxisAlignment: CrossAxisAlignment.start,

children: [

Text('Amount: ${service.billedAmount}'),

Text('Due Date: ${service.dueDate}'),

],

),

onTap: onTap,

),

);

}

}

class IconTextButton extends StatelessWidget {

final IconData icon;

final String text;

final VoidCallback onTap;

IconTextButton({required this.icon, required this.text, required this.onTap});

@override

Widget build(BuildContext context) {

return InkWell(

onTap: onTap,

child: Column(

children: [

Icon(icon, size: 50),

SizedBox(height: 10),

Text(

text,

style: TextStyle(fontSize: 15),

textAlign: TextAlign.center,

),

],

),

);

}

}

class MobileRechargePage extends StatelessWidget {

final List<Operator> operators = loadOperators();

final TextEditingController mobileNumberController = TextEditingController();

@override

Widget build(BuildContext context) {

return Scaffold(

appBar: AppBar(

title: Text('Mobile Recharge'),

),

body: Padding(

padding: const EdgeInsets.all(16.0),

child: SingleChildScrollView(

child: Column(

crossAxisAlignment: CrossAxisAlignment.start,

children: <Widget>[

// Mobile Number Entry Field with India Flag Icon

Row(

children: [

Container(

padding: EdgeInsets.symmetric(horizontal: 8.0),

child: Icon(Icons.search), // You can replace this with your desired search icon

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

),

),

),

],

),

SizedBox(height: 40),

// Bold Text - Mobile Operators

Text(

'Mobile Operators',

style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),

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

mobileNumber: mobileNumberController.text, selectedPlans: [],

),

),

);

},

child: ListTile(

leading: CircleAvatar(

backgroundImage: AssetImage(operator.iconPath),

),

title: Text(operator.name),

subtitle: Text('Type: ${operator.type}'),

),

);

}).toList(),

),

SizedBox(height: 20),

ElevatedButton(

onPressed: () {

print('Processing mobile recharge for number entered');

},

child: Text('Recharge Now'),

),

],

),

),

),

);

}

}

class OperatorDetailsPage extends StatefulWidget {

final Operator operator;

final String mobileNumber;

// Pass the selected plans to OperatorDetailsPage

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

// Assuming loadPlans() is a function to load plans for the selected operator

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

),

body: Padding(

padding: const EdgeInsets.all(16.0),

child: Column(

crossAxisAlignment: CrossAxisAlignment.start,

children: <Widget>[

// Text('Mobile Number: $mobileNumber'),

Text('Operator: ${widget.operator.name}'),

Text('Type: ${widget.operator.type}'),

SizedBox(height: 20),

// Display plans with checkboxes

Expanded(

child: ListView.builder(

itemCount: plans.length,

itemBuilder: (context, index) {

return ListTile(

title: Text(plans[index].name),

subtitle: Text('Amount: ${plans[index].amount}'),

trailing: Checkbox(

value: selectedPlans[index],

onChanged: (value) {

setState(() {

selectedPlans[index] = value!;

});

},

),

);

},

),

),

SizedBox(height: 20),

// Pay Recharge Button

ElevatedButton(

onPressed: () {

// Perform payment for selected plans

List<Plan> selectedPlansList = [];

for (int i = 0; i < selectedPlans.length; i++) {

if (selectedPlans[i]) {

selectedPlansList.add(plans[i]);

}

}

if (selectedPlansList.isNotEmpty) {

// Implement payment logic here

// You can navigate to a payment page or show a payment dialog

print(

'Processing payment for selected plans: $selectedPlansList');

// Navigate to PaymentSuccessfulPage with mobileNumber and selectedPlans

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

// Show a message if no plans are selected

ScaffoldMessenger.of(context).showSnackBar(

SnackBar(

content: Text('Please select at least one plan.'),

),

);

}

},

child: Text('Pay Recharge'),

),

],

),

),

);

}

}

class PaymentSuccessfulPage extends StatelessWidget {

final String mobileNumber;

final List<Plan> selectedPlans;

PaymentSuccessfulPage({

required this.mobileNumber,

required this.selectedPlans,

});

@override

Widget build(BuildContext context) {

return Scaffold(

appBar: AppBar(

title: Text('Payment Successful'),

),

body: Padding(

padding: const EdgeInsets.all(16.0),

child: Column(

crossAxisAlignment: CrossAxisAlignment.start,

children: <Widget>[

Text('Mobile Number: $mobileNumber'),

SizedBox(height: 20),

Text('Selected Plans:'),

Column(

crossAxisAlignment: CrossAxisAlignment.start,

children: selectedPlans.map((plan) {

return Text('${plan.name} - Amount: ${plan.amount}');

}).toList(),

// ... (you can add more details if needed)

),

],

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

// Implement this function to load plans for the selected operator

// You can use the operator information to fetch plans from a database or other source

// For now, let's assume some dummy plans.

return [

Plan(name: 'Plan 1', amount: 100.0),

Plan(name: 'Plan 2', amount: 200.0),

Plan(name: 'Plan 3', amount: 300.0),

// Add more plans as needed

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


