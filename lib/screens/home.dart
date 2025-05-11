import 'package:expense_tracker/models/category.dart';
import 'package:expense_tracker/widgets/new_expense_form.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';
import '../widgets/expense_tile.dart';

class ExpenseTrackerHome extends StatefulWidget {
  const ExpenseTrackerHome({super.key});

  @override
  State createState() => _ExpenseTrackerHome();
}

class _ExpenseTrackerHome extends State {
  final List<Expense> _registeredExpenses = [
    Expense(
      id: 1,
      title: 'Groceries',
      amount: 100.0,
      date: DateTime.now(),
      category: Category.food,
    ),
    Expense(
      id: 2,
      title: 'Electricity Bill',
      amount: 140.0,
      date: DateTime.now(),
      category: Category.bills,
    ),
  ];

  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _openAddExpenseForm() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: NewExpenseForm(onSubmit: _addNewExpense)
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Expenses')),
      body: ListView.builder(
        itemCount: _registeredExpenses.length,
        itemBuilder: (context, index) {
          final expense = _registeredExpenses[index];
          return ExpenseTile(key: ValueKey(expense.id), expense: expense);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseForm,
        tooltip: 'Add Expense',
        child: Icon(Icons.add),
      ),
    );
  }
}
