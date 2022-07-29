// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'widgets/transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          // ignore: deprecated_member_use
          accentColor: const Color.fromARGB(255, 255, 213, 63),
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              // ignore: deprecated_member_use
              textTheme: ThemeData.light().textTheme.copyWith(
                  titleMedium: const TextStyle(fontWeight: FontWeight.bold)))),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> _transactions = [];

  void _addNewTransaction(
      String titletxt, double amountTxt, DateTime selectedDate) {
    final newTranscn = Transaction(
        id: DateTime.now().toString(),
        title: titletxt,
        amount: amountTxt,
        date: selectedDate);

    setState(() {
      _transactions.add(newTranscn);
      //print(_transactions.);
    });
  }

  void deleteTransactions(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        builder: (context) => NewTransaction(_addNewTransaction));
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  bool sVal = true;
  List<Widget> _buildPotraitContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      SizedBox(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.26,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Show Chart", style: TextStyle(fontSize: 17)),
            Switch(
              value: sVal,
              onChanged: (val) {
                setState(() {
                  sVal = val;
                });
              },
            )
          ],
        ),
      ),
      sVal
          ? SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(_recentTransactions))
          : txListWidget
    ];
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'Expense App',
        style: TextStyle(
            fontFamily: 'OpenSans', fontSize: 19, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(Icons.add),
          iconSize: 33,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final _appBar = _buildAppBar();
    final txListWidget = SizedBox(
        height: (mediaQuery.size.height -
                _appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.8,
        child: TransactionList(_transactions, deleteTransactions));

    return Scaffold(
      appBar: _appBar,
      body: ListView(
        children: [
          if (isLandscape)
            ..._buildLandscapeContent(mediaQuery, _appBar, txListWidget),
          if (!isLandscape)
            ..._buildPotraitContent(mediaQuery, _appBar, txListWidget)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 28,
        ),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
