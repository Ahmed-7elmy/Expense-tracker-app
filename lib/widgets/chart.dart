import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;
  List<ExpenseBucket> get buckets {
    return <ExpenseBucket>[
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work),
    ];
  }

  double get maxTotalExpenses {
    double max = 0;
    for (var bucket in buckets) {
      if (bucket.totalExpenses > max) {
        max = bucket.totalExpenses;
      }
    }
    return max;
  }

  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        log(constraint.maxWidth.toString());
        log(constraint.maxHeight.toString());
        log(constraint.minWidth.toString());
        log(constraint.minHeight.toString());

        return Container(
          height: constraint.maxHeight, //the remaining height

          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: buckets
                .map((bucket) => Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        children: [
                          Text(
                            '\$${bucket.totalExpenses.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 100,
                            width: 20,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 187, 27, 190),
                                      width: 1.0,
                                    ),
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                FractionallySizedBox(
                                  heightFactor: maxTotalExpenses == 0
                                      ? 0
                                      : bucket.totalExpenses / maxTotalExpenses,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Icon(
                            categoryIcon[bucket.category],
                            // color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            bucket.category.toString().split('.').last,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          // Text(bucket.totalExpenses.toString())
                        ],
                      ),
                    ))
                .toList(),
          ),
        );
      },
    );
  }
}
