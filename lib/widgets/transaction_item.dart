import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function dltTx;
  const TransactionItem(this.transaction, this.dltTx);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 182, 228, 248),
      elevation: 10,
      margin: const EdgeInsets.only(bottom: 13),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(
            child: Text(
              '\$${transaction.amount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat('MMM d, yyyy').format(transaction.date),
          style: const TextStyle(
              color: Color.fromARGB(255, 110, 110, 110), fontSize: 14.5),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () => dltTx(transaction.id),
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                textColor: const Color.fromARGB(255, 255, 66, 66),
              )
            : IconButton(
                icon: const Icon(
                  Icons.delete,
                  size: 30,
                  color: Color.fromARGB(255, 255, 66, 66),
                ),
                onPressed: () => dltTx(transaction.id),
              ),
      ),
    );
  }
}
