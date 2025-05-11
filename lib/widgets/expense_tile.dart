import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;

  const ExpenseTile({required Key key, required this.expense})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                Text('${expense.date.day.toString().padLeft(2, '0')}-${expense.date.month.toString().padLeft(2, '0')}-${expense.date.year.toString()}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
