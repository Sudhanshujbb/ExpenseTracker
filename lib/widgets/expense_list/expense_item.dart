import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';

class ExpenseItem extends StatelessWidget{
  const ExpenseItem( this.expenseItem, {super.key});

  final Expense expenseItem;
  @override
  Widget build(context){
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
              
              Text(expenseItem.title, 
              style: Theme.of(context).textTheme.titleLarge,
              
              
            ),
            const SizedBox(height: 8),
            Row(children: [
              Text('\$${expenseItem.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(children: [
                Icon(categoryIcons[expenseItem.category]),
                const SizedBox(width: 8,),
                Text(expenseItem.getFormattedDate),
                // Text(expenseItem.category.toString()),
              ],)

            ],),
          ],
        ),
      ),
    );
  }
}