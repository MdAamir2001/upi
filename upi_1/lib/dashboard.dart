import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'sendmoney.dart';
import 'transaction_history_details_screen.dart';
import 'contactscreen.dart';

part 'dashboard.g.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  final double amount;

  @HiveField(1)
  final String userName;

  Transaction({required this.amount, required this.userName});
}

class DashboardScreen extends StatelessWidget {
  final List<Transaction> transactions = [];
  late final Box<Transaction> _transactionBox;

  DashboardScreen() {
    // Open the Hive box for transactions
    Hive.openBox<Transaction>('transactionBox').then((box) {
      _transactionBox = box;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Handle the action when the profile icon is pressed
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
        ],
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/Images/UD2.png'),
        //     fit: BoxFit.fill,
        //   ),
        // ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: EdgeInsets.all(12.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Welcome to the Dashboard!\nExplore the following options:',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
              SizedBox(height: 11.0),
              buildSearchCard(context),
              SizedBox(height: 11.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildOptionCard(
                    context,
                    'QR Code',
                    Icons.qr_code,
                    Colors.cyan.shade50,
                    size: 10.0,
                  ),
                  buildOptionCard(
                    context,
                    'Bills',
                    Icons.receipt,
                    Colors.cyan.shade50,
                    size: 10.0,
                  ),
                  buildOptionCard(
                    context,
                    'Phone Number',
                    Icons.phone,
                    Colors.cyan.shade50,
                    size: 10.0,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Manage Your Money',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 11.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildOptionCard(
                    context,
                    'Manage Account',
                    Icons.account_circle,
                    Colors.cyan.shade50,
                    size: 10.0,
                  ),
                  buildOptionCard(
                    context,
                    'Add Card Details',
                    Icons.credit_card,
                    Colors.cyan.shade50,
                    size: 10.0,
                  ),
                  buildOptionCard(
                    context,
                    'Rewards',
                    Icons.star,
                    Colors.cyan.shade50,
                    size: 20.0,
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                'Bill & Recharges',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildRoundedCard(
                      context, 'Mobile Recharge', Icons.phone_android, Colors.cyan.shade50),
                  buildRoundedCard(context, 'Electricity', Icons.flash_on, Colors.cyan.shade50),
                  buildRoundedCard(context, 'DTH/Cable TV', Icons.tv, Colors.cyan.shade50),
                  buildRoundedCard(context, 'DTH/Cable TV', Icons.tv, Colors.cyan.shade50),
                ],
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () async {
                  // Retrieve transaction history from Hive
                  List<Transaction> transactionHistory = await getTransactionHistory();

                  // Navigate to TransactionHistoryDetailsScreen with the retrieved data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionHistoryDetailsScreen(transactionHistory),
                    ),
                  );
                },
                child: Text('Transaction History'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRoundedCard(BuildContext context, String title, IconData icon, Color color) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100.0),
      ),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 25.0, color: Colors.black),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontSize: 11.0, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchCard(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.0),
      ),
      color: Colors.cyan.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                // Handle the action when the search icon is pressed
                showContacts(context);
              },
              child: Icon(Icons.search, size: 30.0, color: Colors.grey),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  // Fetch and filter your contacts based on the entered text
                  // Replace this with your actual contact fetching logic
                  List<String> contacts = [];

                  return contacts
                      .where((contact) => contact
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()))
                      .toList();
                },
                onSelected: (String selectedContact) {
                  // Handle the selected contact
                  print('Selected Contact: $selectedContact');
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  return TextField(
                    controller: textEditingController,
                    focusNode: focusNode,
                    onSubmitted: (String value) {
                      onFieldSubmitted();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search by Name or Phone Number',
                      border: InputBorder.none,
                    ),
                  );
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<String> onSelected,
                    Iterable<String> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      elevation: 4.0,
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 200.0,
                        ),
                        child: ListView.builder(
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String option = options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                              },
                              child: ListTile(
                                title: Text(option),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showContacts(BuildContext context) {
    // Placeholder function for showing contacts screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactsScreen()), // Create ContactsScreen widget
    );
  }

  Widget buildOptionCard(BuildContext context, String title, IconData icon, Color color, {double size = 40.0}) {
    return GestureDetector(
      onTap: () {
        if (title == 'Phone Number') {
          payUsingPhoneNumber(context);
        } else if (title == 'Manage Account') {
          manageAccount(context);
        } else if (title == 'Add Card Details') {
          addCardDetails(context);
        } else if (title == 'Rewards') {
          viewRewards(context);
        }
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: size, color: Colors.black),
              SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(fontSize: 14.0, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void payUsingPhoneNumber(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SendMoneyScreen(contactName: '')),
    );
  }

  void manageAccount(BuildContext context) {
    // Implement the action for managing account
  }

  void addCardDetails(BuildContext context) {
    // Implement the action for adding card details
  }

  void viewRewards(BuildContext context) {
    // Implement the action for viewing rewards
  }

  void addTransaction(double amount, String userName) {
    // Create a new transaction
    Transaction newTransaction = Transaction(amount: amount, userName: userName);

    // Add the transaction to the list
    transactions.add(newTransaction);
  }

  Future<List<Transaction>> getTransactionHistory() async {
    try {
      // Make sure _transactionBox is not null before trying to access it
      if (_transactionBox == null) {
        throw Exception('Transaction box not opened');
      }

      // Retrieve all transactions from Hive
      List<Transaction> transactionHistory = _transactionBox.values.toList().cast<Transaction>();

      return transactionHistory;
    } catch (e) {
      print('Error getting transaction history: $e');
      return [];
    }
  }
}
