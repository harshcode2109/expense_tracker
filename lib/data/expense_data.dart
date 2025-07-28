import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseData extends ChangeNotifier {
  final List<Expense> _expenses = [];

  List<Expense> get allExpenses => _expenses;

  void addExpense(Expense expense) {
    _expenses.add(expense);
    notifyListeners();
  }

  void removeExpense(Expense expense) {
    _expenses.remove(expense);
    notifyListeners();
  }
}
