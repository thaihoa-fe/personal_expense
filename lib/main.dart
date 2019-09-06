import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          fontFamily: 'Quicksan',
          primarySwatch: Colors.pink,
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans', fontSize: 16, color: Colors.black),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans', fontSize: 20, color: Colors.black)),
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [];
  var _showChart = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    print(state);
  }

  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _addTransaction(String title, double amount, DateTime date) {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: date,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  void _deleteTransaction(Transaction transaction) {
    setState(() {
      _userTransactions.removeWhere((item) => item.id == transaction.id);
    });
  }

  List<Transaction> get _recentTransactions {
    final sevenDaysBefore = DateTime.now().subtract(Duration(days: 7));

    return _userTransactions
        .where((transaction) => transaction.date.isAfter(sevenDaysBefore))
        .toList();
  }

  PreferredSizeWidget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => startAddNewTransaction(context),
              )
            ],
          );
  }

  void _toggleShowChart(value) {
    setState(() {
      _showChart = value;
    });
  }

  Widget _buildChart() {
    return Chart(
      recentTransactions: _recentTransactions,
    );
  }

  Widget _buildTransactionList() {
    return TransactionList(
      deleteTransaction: _deleteTransaction,
      transactions: _userTransactions,
    );
  }

  List<Widget> _buildLandscapeContent(double contentHeight, Widget transactionList) {
    return [
      Row(
        key: ValueKey('switch'),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_showChart ? 'Hide chart' : 'Show chart'),
          Switch(
            value: _showChart,
            onChanged: _toggleShowChart,
          )
        ],
      ),
      _showChart
          ? Container(
              key: ValueKey('chart'),
              height: contentHeight * 0.8,
              child: _buildChart(),
            )
          : Container(
              key: ValueKey('list'),
              height: contentHeight * 0.8,
              child: transactionList,
            )
    ];
  }

  List<Widget> _buildPortraitContent(double contentHeight, Widget transactionList) {
    return [
      Container(
        key: ValueKey('chart'),
        height: contentHeight * 0.3,
        child: _buildChart(),
      ),
      Container(
        key: ValueKey('list'),
        height: contentHeight * 0.7,  
        child: transactionList,
      )
    ];
  }

  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = _buildAppBar();
    final transactionList = _buildTransactionList();
    final contentHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape) ..._buildLandscapeContent(contentHeight, transactionList),
            if (!isLandscape) ..._buildPortraitContent(contentHeight, transactionList),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          startAddNewTransaction(context);
        },
      ),
    );
  }
}
