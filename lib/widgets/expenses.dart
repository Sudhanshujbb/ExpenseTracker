
// import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpensesState(); 
  }
}

class _ExpensesState extends State<Expenses>{

    final List<Expense> _registeredExpenses = [
      Expense(title: 'Flutter Course', date: DateTime.now(), amount: 529.00, category: Category.education),
      Expense(title: 'Mobile Recharge', date: DateTime.now(), amount: 219.00, category: Category.other),
      Expense(title: '5 kg Rice', date: DateTime.now(), amount: 200.00, category: Category.food),
      Expense(title: '5 kg Flour(aata)', date: DateTime.now(), amount: 529.00, category: Category.food),
    ];

    void _addExpense(Expense exp){
      setState(() {
        _registeredExpenses.add(exp);
      });
      
    }

    void _removeExpense(Expense exp){
      final index = _registeredExpenses.indexOf(exp);
      setState(() {
        _registeredExpenses.remove(exp);
      });

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text('Expense Deleted'),
          action: SnackBarAction(
            label:'Undo',
            onPressed: (){
              setState(() {
                _registeredExpenses.insert(index, exp);
              });
            },
            ),

          )
      );
    }

    void _openAddExpenseOverlay(){
      showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context, builder: (ctx){
        return NewExpense(onAddExpense: _addExpense);
      });
    }

    @override
    Widget build(BuildContext context){
      final width = MediaQuery.of(context).size.width;
      
      Widget mainContent = const Center(child: Text('No Expense Found. Start Adding Some!!'),);
      if(_registeredExpenses.isNotEmpty){
        mainContent = ExpenseList(expenses: _registeredExpenses, onDismised: _removeExpense,);
      }
      return Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
        title: const Text('Expense Tracker'),
        ),
        body: width<600? Column(
          children: [
            Expanded(child: Chart(expenses: _registeredExpenses)),
            const SizedBox(height: 16,),
            Expanded(child: mainContent),
          ])
          : Row(
            children: [
            Expanded(child: Chart(expenses: _registeredExpenses)),
            
            Expanded(child: mainContent),
          ])
          );
      
    }
}