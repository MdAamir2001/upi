import 'package:hive/hive.dart';

import 'dashboard.dart';

class HiveOperations {
  static Future<List<Transaction>> getTransactionHistory() async {
    final _transactionBox = await Hive.openBox('transactionBox');

    // Retrieve all transactions from Hive
    List<Transaction> transactionHistory = _transactionBox.values.toList().cast<Transaction>();

    // Close the Hive box
    await _transactionBox.close();

    return transactionHistory;
  }
}
