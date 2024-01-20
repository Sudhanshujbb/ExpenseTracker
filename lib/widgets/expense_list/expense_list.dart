
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget{
const ExpenseList({ required this.expenses, super.key,  required this.onDismised});
final void Function(Expense expense) onDismised;
final List<Expense> expenses;
  @override
  Widget build(BuildContext context){
    return ListView.builder(itemCount: expenses.length, itemBuilder: (ctx, index){
           return Dismissible(
            background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.84),
            margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal,)
            ),
            key:ValueKey(expenses[index]), 
            onDismissed: (direction){
              onDismised(expenses[index]);
            },
            child: ExpenseItem(expenses[index]));
    },);
  }
}