import 'package:expense_tracker/widgets/add_expense.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Temporary list of expenses (we'll store them permanently later)
  final List<Expense> _expenses = [];

  // Function to add a new expense (we’ll hook it with a form later)
  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  return AddExpense(onAddExpense: _addExpense);
                },
                // This will open the add expense form late
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: _expenses.isEmpty
          ? const Center(child: Text('No expenses yet. Add some!'))
          : ListView.builder(
              itemCount: _expenses.length,
              itemBuilder: (context, index) {
                final expense = _expenses[index];
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
