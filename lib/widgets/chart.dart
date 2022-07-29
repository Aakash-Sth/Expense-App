import 'package:expense_app/widgets/chart_bar.dart';
import 'package:expense_app/widgets/transaction.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  int ind = 6;
  List<Map<String, Object>> get transactionGroup {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double total = 0.0;
      for (int i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          total += recentTransaction[i].amount;
        }
      }
      ind--;
      return {'day': DateFormat.E().format(weekDay), 'amount': total};
    }).reversed.toList();
  }

  double get totalSpending {
    return transactionGroup.fold(0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(10),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...transactionGroup.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: (ChartBar(
                    (data['day'] as String),
                    (data['amount'] as double),
                    totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending,
                  )),
                );
              }).toList()
            ],
          ),
        ));
  }
}
