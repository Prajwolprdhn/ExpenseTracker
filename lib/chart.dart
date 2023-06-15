import 'package:expenses_tracker/chartbar.dart';
import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);
//creating how many values to list interms of days
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].dateTime.day == weekDay.day &&
            recentTransaction[i].dateTime.month == weekDay.month &&
            recentTransaction[i].dateTime.year == weekDay.year) {
          totalSum = totalSum + recentTransaction[i].amount;
        }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {"day": DateFormat.E().format(weekDay), "amount": totalSum};
    });
  }

//get total spending on that period/day
  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: groupedTransactionValues.map((data) {
          return ChartBar(data['day'].toString(), data['amount'] as double,
              (data['amount'] as double) / totalSpending);
        }).toList(),
      ),
    );
  }
}
