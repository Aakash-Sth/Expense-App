// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;

  NewTransaction(this.newTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submit() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final inputTitle = _titleController.text;
    final inputAmount = double.parse(_amountController.text);
    if (inputTitle.isEmpty || inputAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.newTx(_titleController.text, double.parse(_amountController.text),
        _selectedDate);
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 6)),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submit(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submit(),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "No date chosen."
                          : 'Date : ${DateFormat('MMM d, yyyy').format(_selectedDate)}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  TextButton(
                      onPressed: _datePicker,
                      child: Text("Choose date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.5)))
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text(
                'Add Transaction',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              style: TextButton.styleFrom(
                  onSurface: Color.fromARGB(255, 155, 0, 245)),
            )
          ],
        ),
      ),
    );
  }
}
