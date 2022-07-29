// ignore_for_file: deprecated_member_use

import 'package:expense_app/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

import 'transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function dltTx;

  const TransactionList(this.transactions, this.dltTx);

  @override
  Widget build(BuildContext context) {
    return (Card(
        child: transactions.isEmpty
            ? LayoutBuilder(builder: ((context, constraints) {
                return Column(
                  children: [
                    const Text(
                      'No transactions added yet.',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              }))
            : ListView.builder(
                itemBuilder: (context, index) {
                  return TransactionItem(transactions[index], dltTx);
                },
                itemCount: transactions.length,
              )));
  }
}
