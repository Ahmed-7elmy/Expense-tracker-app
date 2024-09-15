//import 'dart:math';

import 'package:app03/widgets/bottomsheet.dart';
import 'package:app03/widgets/chart.dart';
import 'package:app03/widgets/expanse_list/expanses_list.dart';
import 'package:flutter/material.dart';
import '../models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> registeredExpenses = [
    Expense(
        category: Category.work,
        title: 'flutter',
        amount: 29,
        date: DateTime.now()),
    Expense(
        category: Category.food,
        title: 'burger',
        amount: 5,
        date: DateTime.now())
  ];
  void _addExpense(Expense expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      registeredExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('EXPENSE TRACKER'),
        leading: const Icon(Icons.abc),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (c) => Bottomsheet(onADDExpense: _addExpense));
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: width < 600
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Chart(expenses: registeredExpenses)),
                  Expanded(
                    child: ExpensesList(
                      expenses: registeredExpenses,
                      onremoveExpense: _removeExpense,
                    ),
                  )
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Chart(expenses: registeredExpenses)),
                  Expanded(
                    child: ExpensesList(
                      expenses: registeredExpenses,
                      onremoveExpense: _removeExpense,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
