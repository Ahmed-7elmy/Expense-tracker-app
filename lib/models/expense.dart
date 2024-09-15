import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
final dateFormat = DateFormat.yMd();

enum Category {
  food,
  travel,
  leisure,
  work,
}

const categoryIcon = {
  Category.food: Icons.restaurant,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  final Category category;
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  String get formattedDate {
    return dateFormat.format(date);
  }

  Expense({
    required this.category,
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expensesBucket;

  ExpenseBucket(this.category, this.expensesBucket);
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expensesBucket =
            allExpenses.where((e) => e.category == category).toList();
  double get totalExpenses {
    double sum = 0;
    for (var expense in expensesBucket) {
      sum += expense.amount;
    }
    return sum;
  }
}

var v1 = Expense(
    category: Category.work,
    title: 'flutter',
    amount: 29,
    date: DateTime.now());
