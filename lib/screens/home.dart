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
  List<int> selectedExpenseId = [];
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

  void _updateExpense(Expense expense) {
    setState(() {
      final index = _registeredExpenses.indexWhere(
        (item) => item.id == expense.id,
      );
      if (index >= 0) {
        _registeredExpenses[index] = expense;
      }
    });
  }

  void toggleSelection(int id, bool selected) {
    setState(() {
      if (selected) {
        selectedExpenseId.add(id);
      } else {
        selectedExpenseId.remove(id);
      }
    });
  }

  void deletedSelectedExpense() {
    setState(() {
      _registeredExpenses.removeWhere(
        (item) => selectedExpenseId.contains(item.id),
      );
    });
  }

  void editSelectedExpense() {
    if (selectedExpenseId.length == 1) {
      final selectedId = selectedExpenseId.first;
      Expense? selectedExpense;
      try {
        selectedExpense = _registeredExpenses.firstWhere(
          (e) => e.id == selectedId,
        );
      } catch (e) {
        selectedExpense = null;
      }

      if (selectedExpense != null) {
        showModalBottomSheet(
          context: context,
          builder: (_) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: NewExpenseForm(
                onSubmit: _updateExpense,
                existingExpense: selectedExpense,
              ),
            );
          },
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Expense not found.")));
      }
    }
  }

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
          child: NewExpenseForm(onSubmit: _addNewExpense),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Expenses'),
        actions: [
          if (selectedExpenseId.length == 1) ...[
            IconButton(
              onPressed: deletedSelectedExpense,
              icon: Icon(Icons.delete),
            ),
            IconButton(onPressed: editSelectedExpense, icon: Icon(Icons.edit)),
          ],
          if (selectedExpenseId.isNotEmpty && selectedExpenseId.length > 1)
            IconButton(
              onPressed: deletedSelectedExpense,
              icon: Icon(Icons.delete),
            ),
        ],
      ),

      body: ListView.builder(
        itemCount: _registeredExpenses.length,
        itemBuilder: (context, index) {
          final expense = _registeredExpenses[index];
          return ExpenseTile(
            key: ValueKey(expense.id),
            expense: expense,
            isSelected: selectedExpenseId.contains(expense.id),
            onSelected: (selected) => toggleSelection(expense.id, selected),
          );
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
