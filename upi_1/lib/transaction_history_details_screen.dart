
import 'package:flutter/material.dart';
import 'package:hive/hive.dart'; // Import Hive package
import 'dashboard.dart';

class TransactionHistoryDetailsScreen extends StatelessWidget {
  final List<Transaction> transactions;
  final Box<Transaction> _transactionBox = Hive.box<Transaction>('transactionBox');

  TransactionHistoryDetailsScreen( this.transactions);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History Details'),
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            title: Text('User Name: ${transaction.userName}'),
            subtitle: Text('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
