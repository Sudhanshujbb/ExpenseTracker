
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
const uuid = Uuid();
enum Category{food, leisure, travel, education, other}
const  categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.education: Icons.menu_book,
  Category.other: Icons.error_outline_sharp,
};

final formater = DateFormat.yMd(); 

class Expense{
  Expense({required this.title, required this.date, required this.amount, required this.category}) : id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get getFormattedDate{
    return formater.format(date);
  }
}

class ExpenseBucket{
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
  :expenses = allExpenses.where((expense) => expense.category == category).toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpense{
    double sum =0;
    for(final expense in expenses){
      sum+=expense.amount;
    }

    return sum;
  }


}