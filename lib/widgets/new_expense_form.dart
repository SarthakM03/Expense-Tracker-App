import 'package:expense_tracker/models/category.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class NewExpenseForm extends StatefulWidget {
  final Function(Expense) onSubmit;
  const NewExpenseForm({required this.onSubmit});

  @override
  _NewExpenseFormState createState() => _NewExpenseFormState();
}

class _NewExpenseFormState extends State<NewExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedCategory = 'food';

  void _presentDatePicker() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void submitForm() {
    if (_titleController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        _selectedDate != null) {
      final title = _titleController.text;
      final amount = double.parse(_amountController.text);
      final newExpense = Expense(
        id: DateTime.now().millisecondsSinceEpoch,
        title: title,
        amount: amount,
        date: _selectedDate!,
        category: Category.values.firstWhere(
          (e) => e.name == _selectedCategory,
        ),
      );
      widget.onSubmit(newExpense);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text('Title')),
          ),

          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(label: Text('Amount')),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedDate == null
                    ? 'no date chosed'
                    : 'Picked Date: ${_selectedDate!.day.toString().padLeft(2, '0')}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.year.toString()}',
              ),
              TextButton(
                onPressed: _presentDatePicker,
                child: Text('Choose Date'),
              ),
            ],
          ),
          DropdownButton<String>(
            value: _selectedCategory,
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
            items: Category.values.map((Category category) {
              return DropdownMenuItem<String>(
                value: category.name,
                child: Text(category.name),
              );
            }).toList(),
          ),

          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: submitForm, 
            child: Text('Add Expense'),
            )
        ],
      ),
    );
  }
}
