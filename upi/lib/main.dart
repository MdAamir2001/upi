// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Images/123.png'), // Replace with the path to your background image asset
            fit: BoxFit.fill,
            // You can adjust the BoxFit as needed
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/Images/123.png', // Replace with the path to your image asset
              //   width: 150.0, // Adjust the width as needed
              //   height: 150.0, // Adjust the height as needed
              // ),
              // SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignInScreen()),
                  );
                },
                child: Text('Sign In'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn(BuildContext context) {
    // Replace this with your sign-in logic
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Implement your sign-in logic, such as making API calls or updating a database
    print('Signing in with $name, $email, and $password');

    // Navigate to Dashboard after signing in
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () => _signIn(context),
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login(BuildContext context) {
    // Replace this with your authentication logic
    String username = _usernameController.text;
    String password = _passwordController.text;

    // For simplicity, let's use hardcoded credentials
    if (username == 'user' && password == 'password') {
      // Navigate to Dashboard after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    } else {
      // Handle unsuccessful login, show error message or anything else
      print('Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
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
              // For example, navigate to the profile screen
              // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.all(12.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              'Welcome to the Dashboard!\nExplore the following options:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.0, color: Colors.white),
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
                Colors.white,
                size: 10.0,
              ),
              buildOptionCard(
                context,
                'Bills',
                Icons.receipt,
                Colors.white,
                size: 10.0,
              ),
              buildOptionCard(
                context,
                'Phone Number',
                Icons.phone,
                Colors.white,
                size: 10.0,
              ),
            ],
          ),

          SizedBox(height: 20.0), // Added space
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
                Colors.white,
                size: 10.0,
              ),
              buildOptionCard(
                context,
                'Add Card Details',
                Icons.credit_card,
                Colors.white,
                size: 10.0,
              ),
              buildOptionCard(
                context,
                'Rewards',
                Icons.star,
                Colors.white,
                size: 20.0,
              ),
            ],
          ),

          SizedBox(height: 20.0), // Added space
          Text(
            'Bill & Recharges',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildRoundedCard(context, 'Mobile Recharge', Icons.phone_android, Colors.white),
              buildRoundedCard(context, 'Electricity', Icons.flash_on, Colors.white),
              buildRoundedCard(context, 'DTH/Cable TV', Icons.tv, Colors.white),
              buildRoundedCard(context, 'DTH/Cable TV', Icons.tv, Colors.white),
            ],
          ),
        ],
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
      color: Colors.white,
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
                  List<String> contacts = [

                  ];

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
        } else {
          // Handle other options
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

  // Placeholder function for QR code payment
  void payUsingPhoneNumber(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SendMoneyScreen(contactName: '',)),
    );
  }

  // Placeholder function for managing account
  void manageAccount(BuildContext context) {
    // Implement the action for managing account
  }

  // Placeholder function for adding card details
  void addCardDetails(BuildContext context) {
    // Implement the action for adding card details
  }

  // Placeholder function for viewing rewards
  void viewRewards(BuildContext context) {
    // Implement the action for viewing rewards
  }


}
class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  List<String> contacts = [];
  List<String> filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _requestContactsPermission();
  }

  Future<void> _requestContactsPermission() async {
    PermissionStatus status = await Permission.contacts.request();
    if (status == PermissionStatus.granted) {
      _loadContacts();
    } else {
      // Handle the case where the user denied access to contacts
      print('Permission denied to access contacts');
    }
  }

  Future<void> _loadContacts() async {
    Iterable<Contact> deviceContacts;
    try {
      deviceContacts = await ContactsService.getContacts();
    } catch (e) {
      // Handle error fetching contacts
      print('Error loading contacts: $e');
      return;
    }

    setState(() {
      contacts = deviceContacts?.map((contact) => contact?.displayName ?? '').toList() ?? [];
      filteredContacts = List.from(contacts); // Initialize the filtered list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ContactsSearchDelegate(filteredContacts),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: filteredContacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredContacts[index]),
              onTap: () {
                navigateToSendMoney(context, filteredContacts[index]);
              },
            );
          },
        ),
      ),
    );
  }


  void navigateToSendMoney(BuildContext context, String contactName) {
    // Implement the action for navigating to the SendMoneyScreen with the selected contact
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AmountEntryScreen(contactName: contactName, onAmountEntered: (double ) {  },),
      ),
    );
  }
}

class ContactsSearchDelegate extends SearchDelegate<String> {
  final List<String> contacts;

  ContactsSearchDelegate(this.contacts);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final List<String> results = contacts
        .where((contact) => contact.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            close(context, results[index]);
          },
        );
      },
    );
  }
}

class SendMoneyScreen extends StatefulWidget {
  final String contactName;

  SendMoneyScreen({required this.contactName});

  @override
  _SendMoneyScreenState createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();


  String? _validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validatePhoneNumber(String value) {
    // Define a regular expression for a valid phone number (10 digits)
    RegExp regex = RegExp(r'^[0-9]{10}$');

    if (value.isEmpty) {
      return 'Phone number is required';
    } else if (!regex.hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }

    return null;
  }

  void _sendMoney(BuildContext context, double enteredAmount) {
    // Validate the name and phone number before sending money
    String name = _nameController.text.trim();
    String phoneNumber = _phoneNumberController.text.trim();

    String? nameError = _validateName(name);
    String? phoneNumberError = _validatePhoneNumber(phoneNumber);

    if (nameError != null || phoneNumberError != null) {
      // Show an alert message for validation errors
      _showAlert('Validation Error', [
        if (nameError != null) nameError,
        if (phoneNumberError != null) phoneNumberError,
      ]);
      return;
    }

    // Implement your sending money logic, such as making API calls or updating a database
    print('Sending $enteredAmount to $name ($phoneNumber)');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SuccessScreen()),
    );
  }

  void _showAlert(String title, List<String> messages) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            for (String message in messages) Text(message),
          ],
        ),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Money to ${widget.contactName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to AmountEntryScreen when the user clicks the button
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AmountEntryScreen(
                      onAmountEntered: (amount) {
                        // Callback to receive the amount entered
                        _sendMoney(context, amount);
                      }, contactName: '',
                    ),
                  ),
                );
              },
              child: Text('Send Money'),
            ),
          ],
        ),
      ),
    );
  }
}


class SuccessScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Money Sent Successfully',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the SuccessScreen
              },
              child: Text('Back to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}


class AmountEntryScreen extends StatefulWidget {
  final Function(double) onAmountEntered;

  AmountEntryScreen({required this.onAmountEntered, required String contactName});

  @override
  _AmountEntryScreenState createState() => _AmountEntryScreenState();
}

class _AmountEntryScreenState extends State<AmountEntryScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Amount'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                double amount = double.tryParse(_amountController.text) ?? 0.0;
                widget.onAmountEntered(amount);

                // You can optionally navigate to another screen here
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NextScreen()),
                // );
              },
              child: Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}