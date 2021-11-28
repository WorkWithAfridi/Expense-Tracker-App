import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/model/transaction_class.dart';

class TrasactionList extends StatefulWidget {
  final List<Transaction> userTransactions;
  final Function deleteTransaction;
  const TrasactionList({Key? key, required this.userTransactions,required this.deleteTransaction})
      : super(key: key);

  @override
  State<TrasactionList> createState() => _TrasactionListState();
}

class _TrasactionListState extends State<TrasactionList> {
  @override
  Widget build(BuildContext context) {
    return widget.userTransactions.isNotEmpty
        ? ListView.builder(
            itemCount: widget.userTransactions.length,
            itemBuilder: (BuildContext context, int index) {
              Transaction currentTransaction =widget.userTransactions[index];
              return Card(
                elevation: 6,
                shadowColor: Colors.black,
                child: Center(
                  child: ListTile(
                    title: Row(
                      children: [
                        Text(
                          '\$${currentTransaction.amount}',
                          style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        const Text(
                          '- Spent on',
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Expanded(
                          child: Text(
                            '${currentTransaction.title}',
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(
                              fontSize: 17,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.blueGrey,
                      onPressed: () {
                        widget.deleteTransaction(currentTransaction.id);
                      },
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(currentTransaction.date),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Its quite lonely down here! :(', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.6),),),
                Text('Maybe you could add some data? :)', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(0.6)),),
              ],
            ),
          );
  }
}
