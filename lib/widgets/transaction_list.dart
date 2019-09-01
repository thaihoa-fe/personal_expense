import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No transaction added yet',
                    style: Theme.of(context).textTheme.title),
                SizedBox(
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
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, i) {
                final transaction = transactions[i];

                return Card(
                  elevation: 0.5,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 8.0),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('\$${transaction.amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transaction.title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transaction.date),
                        style: TextStyle(color: Color.fromRGBO(90, 90, 90, 1)),
                      ),
                      trailing: IconButton(
                        color: Theme.of(context).errorColor,
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteTransaction(transaction),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
