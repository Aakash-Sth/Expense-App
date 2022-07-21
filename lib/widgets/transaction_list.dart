// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  Function dltTx;

  TransactionList(this.transactions, this.dltTx);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return (Card(
        child: widget.transactions.isEmpty
            ? LayoutBuilder(builder: ((context, constraints) {
                return Column(
                  children: [
                    Text(
                      'No transactions added yet.',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
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
                  return Card(
                    color: Color.fromARGB(255, 182, 228, 248),
                    elevation: 10,
                    margin: EdgeInsets.only(bottom: 13),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Text(
                            '\$${widget.transactions[index].amount.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      title: Text(
                        widget.transactions[index].title,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        DateFormat('MMM d, yyyy')
                            .format(widget.transactions[index].date),
                        style: TextStyle(
                            color: Color.fromARGB(255, 110, 110, 110),
                            fontSize: 14.5),
                      ),
                      trailing: MediaQuery.of(context).size.width > 400
                          ? FlatButton.icon(
                              onPressed: () =>
                                  widget.dltTx(widget.transactions[index].id),
                              icon: Icon(Icons.delete),
                              label: Text("Delete"),
                              textColor: Color.fromARGB(255, 255, 66, 66),
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 30,
                                color: Color.fromARGB(255, 255, 66, 66),
                              ),
                              onPressed: () =>
                                  widget.dltTx(widget.transactions[index].id)

                              //widget.changeState();
                              ,
                            ),
                    ),
                  );
                },
                itemCount: widget.transactions.length,
                //     children: transactions.map((tx) {
                //   return
                // }).toList()),
              )));
  }
}
