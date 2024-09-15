//import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../models/expense.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Bottomsheet extends StatefulWidget {
  const Bottomsheet({super.key, required this.onADDExpense});
  final void Function(Expense expense) onADDExpense;

  @override
  State<Bottomsheet> createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  final formatter = DateFormat.yMd();
  DateTime? _selectdDate;
  Category _selectedCategory = Category.travel;

  @override
  void dispose() {
    super.dispose();
    _titlecontroller.dispose();
    _amountcontroller.dispose();
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (cotx) => AlertDialog(
        title: const Text('ERROR'),
        content: const Text('Please fill in all fields'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(cotx);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(34.0),
          child: Column(
            children: [
              TextField(
                controller: _titlecontroller,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title'),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountcontroller,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text('Amount'),
                          prefixText: '\$',
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(_selectdDate == null
                              ? 'no date'
                              : formatter.format(_selectdDate!)),
                          IconButton(
                            onPressed: () async {
                              final now = DateTime.now();
                              final firstDate =
                                  DateTime(now.year - 1, now.month, now.day);
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: now,
                                firstDate: firstDate,
                                lastDate: now,
                              );
                              setState(() {
                                _selectdDate = pickedDate;
                              });
                            },
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((e) =>
                              DropdownMenuItem(value: e, child: Text(e.name)))
                          .toList(),
                      onChanged: (newCat) {
                        setState(() {
                          if (newCat == null) return;
                          _selectedCategory = newCat;
                        });
                      }),
                  ElevatedButton(
                    onPressed: () {
                      final double? enteredamount =
                          double.tryParse(_amountcontroller.text);
                      if (enteredamount == null || enteredamount < 0) {
                        //fe 7aga na2sa
                      }
                      if (_titlecontroller.text.trim().isEmpty ||
                          _amountcontroller.text.isEmpty) {
                        Platform.isIOS
                            ? showCupertinoDialog(
                                context: context,
                                builder: (cotx) => CupertinoAlertDialog(
                                      title: const Text('ERROR'),
                                      content: const Text(
                                          'Please fill in all fields'),
                                      actions: [
                                        CupertinoDialogAction(
                                          onPressed: () {
                                            Navigator.pop(cotx);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ))
                            : _showDialog();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Please fill in all fields')),
                        );
                        return;
                      } else {
                        widget.onADDExpense(Expense(
                            category: _selectedCategory,
                            title: _titlecontroller.text,
                            amount: enteredamount!,
                            date: _selectdDate!));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
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
