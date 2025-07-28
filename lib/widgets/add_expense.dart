import 'package:flutter/material.dart';
import '../models/expense.dart';

class AddExpense extends StatefulWidget {
  final Function(Expense) onAddExpense;

  const AddExpense({super.key, required this.onAddExpense});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;

  void _submitExpense() {
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);

    if (title.isEmpty || amount == null || amount <= 0) return;

    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
      category: _selectedCategory,
    );

    widget.onAddExpense(newExpense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets.add(const EdgeInsets.all(16)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          const SizedBox(height: 12),
          DropdownButton<Category>(
            value: _selectedCategory,
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
            items: Category.values.map((category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category.name),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _submitExpense,
            child: const Text('Add Expense'),
          ),
        ],
      ),
    );
  }
}
