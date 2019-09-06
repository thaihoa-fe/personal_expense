import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('No transaction added yet',
                  style: Theme.of(context).textTheme.title),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                child: Image.asset(
                  'assets/images/empty.png',
                  fit: BoxFit.cover,
                ),
              )
            ],
          )
        : ListView(
            children: transactions.map((transaction) => TransactionItem(
                transaction: transaction,
                deleteTransaction: deleteTransaction,
                key: ValueKey(transaction.id),
              )).toList(),
          );
  }
}
