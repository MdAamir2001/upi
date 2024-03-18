import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Success.dart';
import 'amountscreen.dart';
import 'main.dart';

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
        builder: (context) => AmountEntryScreen(
          contactName: contactName,
          // Placeholder for the action when amount is entered
          onAmountEntered: (double amount) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SuccessScreen()));
          }, enteredAmount: null,
        ),
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
