import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:personal_expense_tracker/controller/file_operations_controller.dart';
import 'package:personal_expense_tracker/model/transaction_class.dart';
import 'package:personal_expense_tracker/screen/add_new_transaction_controller.dart';
import 'package:personal_expense_tracker/view/transaction_list.dart';
import 'package:personal_expense_tracker/view/weekly_spending_chart.dart';

void main() {
  runApp(const PersonalExpenseTracker());
}

class PersonalExpenseTracker extends StatefulWidget {
  const PersonalExpenseTracker({Key? key}) : super(key: key);

  @override
  _PersonalExpenseTrackerState createState() => _PersonalExpenseTrackerState();
}

class _PersonalExpenseTrackerState extends State<PersonalExpenseTracker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expense App',
      theme: ThemeData(
        primaryColor: Colors.blue,
        secondaryHeaderColor: Colors.white,
        backgroundColor: Colors.black87,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Transaction> userTransactions = [];

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //
  //   saveData();
  // }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   saveData();
  //   super.dispose();
  // }

  void addTransaction(String id, String title, double amount, DateTime date) {
    userTransactions.add(Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: date));
    updateUserTransactions();
    saveData();
  }

  void deleteTransaction(String removedItemId) {
    userTransactions
        .removeWhere((transaction) => transaction.id == removedItemId);
    updateUserTransactions();
    saveData();
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  late List<Transaction> _userTransactions = userTransactions;
  void updateUserTransactions() {
    setState(() {
      _userTransactions = userTransactions;
    });
  }

  void saveData() {
    print('Saving data');
    String jsonTransaction = jsonEncode(userTransactions);
    int numberOfTransactions = userTransactions.length;
    fileOperations().writeToFile(jsonTransaction, numberOfTransactions);
  }

  void getData() async {
    print('Retrieving data');
    String userTransactionsStoredInFile =
        await fileOperations().readUserTransactionsFromFile();
    // print(userTransactionsStoredInFile);

    if (userTransactionsStoredInFile == "No Data") {
    } else {
      var dataForUserTransactions = jsonDecode(userTransactionsStoredInFile);

      String numberOfUserTransactionsInStringFormat =
          await fileOperations().readNumberOfUserTransactionsFromFile();
      int numberOfUserTransactions =
          int.parse(numberOfUserTransactionsInStringFormat);
      for (int i = 0; i < numberOfUserTransactions; i++) {
        userTransactions.add(Transaction(
            id: dataForUserTransactions[i]["id"],
            title: dataForUserTransactions[i]["title"],
            amount: dataForUserTransactions[i]["amount"],
            date: DateTime.parse(dataForUserTransactions[i]["date"])));
        updateUserTransactions();
      }
    }
  }

  void updateUserData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          title: Text('Personal Expense tracker'),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).backgroundColor,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                flex: 8,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.redAccent,
                  child: TrasactionList(
                    userTransactions: _userTransactions,
                    deleteTransaction: deleteTransaction, //Function
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Divider(
                        color: Colors.black87,
                        height: 50,
                      ),
                    ),
                  ),
                  Text(
                    'Summary of last 7 days',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                      child: Divider(
                        color: Colors.black87,
                        height: 50,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        color: Theme.of(context).primaryColor,
                      )),
                ],
              ),
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 8,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height,
                          child: WeeklySpendingBarChart(
                              userTransactions: _userTransactions),
                          // color: Colors.yellow,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).primaryColor,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 2.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0,
                                      2.0), // shadow direction: bottom right
                                )
                              ]),
                          child: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddNewTransaction(
                                    addNewTransaction: addTransaction,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
