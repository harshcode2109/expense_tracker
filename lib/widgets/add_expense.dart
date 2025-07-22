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
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text);
    final validAmount = enteredAmount != null && enteredAmount > 0;

    if (enteredTitle.isEmpty || !validAmount || _selectedDate == null) {
      return;
    }

    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: enteredTitle,
      amount: enteredAmount, 
      date: _selectedDate!,
      category: _selectedCategory,
    );

    widget.onAddExpense(newExpense);
    Navigator.of(context).pop(); // close the bottom sheet
  }

  void _pickDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Amount (₹)'),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? 'No Date Chosen!'
                      : 'Picked Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                ),
                const Spacer(),
                TextButton(
                  onPressed: _pickDate,
                  child: const Text('Choose Date'),
                )
              ],
            ),
            DropdownButton<Category>(
              value: _selectedCategory,
              items: Category.values
                  .map(
                    (cat) => DropdownMenuItem(
                      value: cat,
                      child: Text(cat.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedCategory = value;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Add Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
