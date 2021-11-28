import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  const AddNewTransaction({Key? key, required this.addNewTransaction})
      : super(key: key);

  @override
  _AddNewTransactionState createState() => _AddNewTransactionState();
}

class _AddNewTransactionState extends State<AddNewTransaction> {
  final amountSpentOnController = TextEditingController();
  final amountSpentController = TextEditingController();
  late var selectedDate = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a new transaction',
          style: TextStyle(fontSize: 15),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Container(
        // color: Theme.of(context).primaryColor,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: amountSpentOnController,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Spent on:',
                  hintText: 'Bird foodies',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: amountSpentController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount:',
                  hintText: '4.20',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(selectedDate == null
                        ? 'No date chosen!'
                        : 'Picked date: ${DateFormat.yMd().format(selectedDate)}'),
                  ),
                  GestureDetector(
                      onTap: () {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1997),
                                lastDate: DateTime.now())
                            .then((pickedDate) => {
                                  if (pickedDate != null)
                                    {
                                      setState(() {
                                        selectedDate = pickedDate;
                                      })
                                    }
                                });
                      },
                      child: Row(
                        children: [
                          const Text(
                            '*',
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            'Choose Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ))
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  String title = amountSpentOnController.text.toString();
                  // double amount = double.parse(amountSpentController.text);
                  String amount = amountSpentController.text;
                  if (title.isEmpty || amount.isEmpty || selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            const Text(
                              '*',
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(' marked fields cannot be null!', style: TextStyle(color: Theme.of(context).primaryColor),),
                          ],
                        ),
                        duration: const Duration(seconds: 3),
                        // backgroundColor: Theme.of(context).primaryColor,
                      ),
                    );
                  }
                  if (title.isNotEmpty &&
                      amount.isNotEmpty &&
                      selectedDate != null) {
                    widget.addNewTransaction(selectedDate.toString(), title,
                        double.parse(amountSpentController.text), selectedDate);
                    Navigator.pop(context);
                  }
                },
                child: Text('Add Transaction'),
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
