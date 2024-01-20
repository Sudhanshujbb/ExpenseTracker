import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense.dart';
// import 'package:expense_tracker/widgets/expenses.dart';
class NewExpense extends StatefulWidget{
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState(){
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';
  // void _saveTitle(String inputValue){
  //   _enteredTitle = inputValue;
  // }
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime ?_selectedDate;
  var _selectedCategory = Category.education;

  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <=0;
    if(_titleController.text.trim().isEmpty || _selectedDate == null || amountIsInvalid ){
      // Errro Message

      showDialog(context: context, builder: (ctx){
        return AlertDialog(title: const Text('Invalid Input'),
        content: const Text('Please Make Sure valid title, amount, date and category was entered'),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(ctx);
          }, child: const Text('Okay'))
        ],);
      });
      return;
    }
   
    
    
    widget.onAddExpense(Expense(title: _titleController.text, date: _selectedDate!, amount: enteredAmount, category: _selectedCategory));
    Navigator.pop(context);
  }

  void _presentDatePicker() async{
    final now = DateTime.now();
    final firstDate = DateTime(now.year-1, now.month, now.day);
    final _pickedDate = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedDate = _pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final appWidth = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      
      builder: (ctx, constraints){
        final width = constraints.maxWidth;
        return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, appWidth+16),
            child: Column(
              
              children: [
              if (width>=600)
                Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Expanded(
                    child: TextField(
                    // onChanged: _saveTitle,
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                                  ),
                  ),
                  const SizedBox(width:  24,),
                  Expanded(child: TextField(
                      // onChanged: _saveTitle,
                      controller: _amountController,
                      // prefixIcon: Tex('$'),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Amount'),
                      ),
              
                )),

                
                ],)
              else
                TextField(
                  // onChanged: _saveTitle,
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
          if(width>=600)
              Row(children: [
                DropdownButton(
                    value: _selectedCategory,
                    items: Category.values.map((category) => 
                           DropdownMenuItem(value: category, child: Text(category.name.toUpperCase()))).toList(), 
                           onChanged: (value){
                            if(value==null){
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                           }
                  ),
                  const SizedBox(width: 24,),
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate== null? 'No Date Selected ': formater.format(_selectedDate!)),
            
                      IconButton(
                        onPressed: _presentDatePicker, 
                        icon: const Icon(Icons.calendar_month),
                        ),
                    ],
                   ),
                 ),
              
              
                 

              ],)
          else
              Row(
                children: [
                  
                  
                  Expanded(
                    child: TextField(
                          // onChanged: _saveTitle,
                          controller: _amountController,
                          // prefixIcon: Tex('$'),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            label: Text('Amount'),
                          ),
                  
                    ),
                  ),
                  
            
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(_selectedDate== null? 'No Date Selected ': formater.format(_selectedDate!)),
            
                      IconButton(
                        onPressed: _presentDatePicker, 
                        icon: const Icon(Icons.calendar_month),
                        ),
                    ],
                  ),
              ),
              
        
        
            ],
          ),
          const SizedBox(height: 16,),

          if(width>=600)
              Row(children: [
                const Spacer(),
                  ElevatedButton(onPressed: _submitExpenseData, child: const Text('Save Expense')),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text('Cancel')),
              ],)
          else
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values.map((category) => 
                           DropdownMenuItem(value: category, child: Text(category.name.toUpperCase()))).toList(), 
                           onChanged: (value){
                            if(value==null){
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                           }),
                           const Spacer(),
                  ElevatedButton(onPressed: _submitExpenseData, child: const Text('Save Expense')),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text('Cancel')),
                ],
              )
          ],
          )
          ,),
        ),
      );
    });
    

    
  }

}