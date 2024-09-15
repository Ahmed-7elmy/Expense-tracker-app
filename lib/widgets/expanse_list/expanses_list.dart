import 'package:app03/widgets/expanse_list/expanses_item.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

//import '../expenses.dart';
class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onremoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onremoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (BuildContext context, int index) => Dismissible(
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(1),
          //  margin: EdgeInsets.symmetric(
          //    horizontal: Theme.of(context).cardTheme.margin.horizontal),
        ),
        key: ValueKey(expenses[index]),
        onDismissed: (direction) => onremoveExpense(expenses[index]),
        child: ExpensesItem(
          expense: expenses[index],
        ),
      ),
    );
  }
}
