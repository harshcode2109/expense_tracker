// lib/models/expense.dart

import 'package:flutter/material.dart';

enum Category { food, travel, shopping, bills, other }

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  });
}
