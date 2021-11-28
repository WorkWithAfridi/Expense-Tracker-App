import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_tracker/model/chart_bar.dart';
import 'package:personal_expense_tracker/model/transaction_class.dart';

class WeeklySpendingBarChart extends StatelessWidget {
  final List<Transaction> userTransactions;
  const WeeklySpendingBarChart({Key? key, required this.userTransactions})
      : super(key: key);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < userTransactions.length; i++) {
        if (userTransactions[i].date.day == weekDay.day &&
            userTransactions[i].date.month == weekDay.month &&
            userTransactions[i].date.year == weekDay.year) {
          totalSum += userTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1).toString(),
        'amount': totalSum,
      };
    }).reversed.toList();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shadowColor: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedTransactionsValues.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
              label: (data['day'] as String),
              spendingAmount: (data['amount'] as double),
              spendingPercentageOfTheTotalAmount: totalSpending==0.0?0.0:(data['amount'] as double )/totalSpending,
            ),
          );
        }).toList(),
      ),
    );
  }
  double get totalSpending{
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum+(item['amount'] as double);
    });
  }
}
