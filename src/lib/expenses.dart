import 'package:firebaseconnection/components/chart/chart.dart';
import 'package:firebaseconnection/components/expenses/expense_list.dart';
import 'package:firebaseconnection/components/expenses/new_expense.dart';
import 'package:firebaseconnection/models/expense.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseconnection/login.dart';
import 'package:firebaseconnection/mycolor/appcolor.dart';
import 'package:firebaseconnection/utils/toastutils.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        date: DateTime.now(),
        title: 'Vile Parle',
        amount: 170.0,
        category: Category.taxi),
    Expense(
        date: DateTime.now(),
        title: 'Payade',
        amount: 800.0,
        category: Category.hotel),
    Expense(
        date: DateTime.now(),
        title: 'Chennai',
        amount: 1499.0,
        category: Category.flight),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void onAddExpense(Expense expense) {
    _addExpense(expense);
  }

  void onRemoveExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(
            () {
              _registeredExpenses.insert(expenseIndex, expense);
            },
          ),
        ),
      ),
    );
  }

  void _showModal() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAdd: onAddExpense));
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(

      appBar: AppBar(
          title: Text('Expense Tracker'),
          actions: [IconButton(onPressed: _showModal, icon: Icon(Icons.add)),
            IconButton(
              icon: Icon(Icons.logout,color: MyColor.darkwhite),
              onPressed: (){
                _auth.signOut().then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginForm()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },

            ),SizedBox(width: 30,),]),
      body: SafeArea(
          child: width < height
              ? Column(
                  children: [
                    Chart(expenses: _registeredExpenses),
                    Expanded(
                        child: _registeredExpenses.isEmpty
                            ? const Center(
                                child:
                                    Text('No expenses added. Try adding some!'),
                              )
                            : ExpenseList(
                                expenses: _registeredExpenses,
                                onRemove: onRemoveExpense,
                              ))
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: Chart(expenses: _registeredExpenses)),
                    Expanded(
                      child: _registeredExpenses.isEmpty
                          ? const Center(
                              child:
                                  Text('No expenses added. Try adding some!'),
                            )
                          : ExpenseList(
                              expenses: _registeredExpenses,
                              onRemove: onRemoveExpense,
                            ),
                    ),
                  ],
                )),
    );
  }
}
