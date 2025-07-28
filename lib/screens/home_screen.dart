import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';
import '../data/expense_data.dart';

import 'package:expense_tracker/widgets/add_expense.dart' as my_widgets;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseData = context.watch<ExpenseData>();
    final expenses = expenseData.allExpenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) {
                  return my_widgets.AddExpense(
                    onAddExpense: (expense) {
                      expenseData.addExpense(expense);
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: expenses.isEmpty
          ? const Center(child: Text('No expenses yet. Add some!'))
          : ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Card(
                  child: ListTile(
                    title: Text(expense.title),
                    subtitle: Text(
                      '${expense.amount} ₹ | ${expense.category.name}',
                    ),
                    trailing: Text(
                      '${expense.date.day}/${expense.date.month}/${expense.date.year}',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
