import 'package:flutter/material.dart';
import 'package:sims_ppob_andre/services/transaction_service.dart';

class BalanceProvider with ChangeNotifier {
  int? _balance;
  final TransactionService _transaction = TransactionService();

  int? get balance => _balance;

  Future<int?> fetchBalance() async {
    _balance = await _transaction.fetchBalance();
    notifyListeners();
    return _balance;
  }

  Future<void> transaction(String service_code) async {
    await _transaction.transaction(service_code);
    notifyListeners();
  }
}
