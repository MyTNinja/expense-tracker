import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { dinner, taxi, flight, hotel }

var formatter = DateFormat.yMd();

const categoryIcon = {
  Category.taxi: Icons.local_taxi,
  Category.flight: Icons.flight_takeoff,
  Category.hotel: Icons.hotel,
  Category.dinner: Icons.restaurant
};

class Expense {
  Expense(
      {required this.date,
      required this.title,
      required this.amount,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0.0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}