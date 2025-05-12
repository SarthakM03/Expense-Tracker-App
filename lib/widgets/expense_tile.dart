import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseTile extends StatefulWidget {
  final Expense expense;
  final bool isSelected;
  final Function(bool) onSelected;

  const ExpenseTile({
    required Key key, 
    required this.expense,
    required this.isSelected,
    required this.onSelected,
    })
    : super(key: key);

  @override
  State<ExpenseTile> createState() => _ExpenseTileState();
}

class _ExpenseTileState extends State<ExpenseTile> {


  @override
  Widget build(BuildContext context) {
    final expense = widget.expense;
    return GestureDetector(
      onLongPress: () => widget.onSelected(!widget.isSelected),
      child: Card(
        color: widget.isSelected ? Colors.green[200] : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                expense.category.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(expense.title),
                  Text('Amount: ${expense.amount.toString()}'),
                  Text(
                    '${expense.date.day.toString().padLeft(2, '0')}-${expense.date.month.toString().padLeft(2, '0')}-${expense.date.year.toString()}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
