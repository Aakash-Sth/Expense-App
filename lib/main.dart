// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors

import 'package:expense_app/widgets/chart.dart';
import 'package:expense_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'widgets/transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses App',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Color.fromARGB(255, 255, 213, 63),
          fontFamily: 'Quicksand',
          //textTheme: ThemeData.raw().textTheme.copyWith(),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  titleMedium: TextStyle(fontWeight: FontWeight.bold)))),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //const ({ Key? key }) : super(key: key);
  final List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    // Transaction(
    //   id: 't3',
    //   title: 'New Shoes',
    //   amount: 29.77,
    //   date: DateTime.now().subtract(Duration(days: 2)),
    // ),
    // Transaction(
    //   id: 't4',
    //   title: 'New Shoes',
    //   amount: 15.99,
    //   date: DateTime.now().subtract(Duration(days: 2)),
    // ),
  ];

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
        builder: (context) =>
            Container(child: NewTransaction(_addNewTransaction))
        // builder: (_) {
        //   return GestureDetector(
        //     child: NewTransaction(_addNewTransaction),
        //     behavior: HitTestBehavior.opaque,
        //   );
        // }
        );
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  bool sVal = true;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final _appBar = AppBar(
      title: Text(
        'Expense App',
        style: TextStyle(
            fontFamily: 'OpenSans', fontSize: 19, fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
          iconSize: 33,
        )
      ],
    );
    final txListWidget = SizedBox(
        height: (mediaQuery.size.height -
                _appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.8,
        child: TransactionList(_transactions, deleteTransactions));

    return Scaffold(
      appBar: _appBar,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            (Container(
              height: (mediaQuery.size.height -
                      _appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart", style: TextStyle(fontSize: 17)),
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
            )),
          if (!isLandscape)
            (SizedBox(
                height: (mediaQuery.size.height -
                        _appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.23,
                child: Chart(_recentTransactions))),
          if (!isLandscape)
            (txListWidget)
          else
            sVal
                ? SizedBox(
                    height: (mediaQuery.size.height -
                            _appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.6,
                    child: Chart(_recentTransactions))
                : txListWidget
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 28,
        ),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
