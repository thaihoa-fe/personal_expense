import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin:
          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
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
            style: const TextStyle(color: Color.fromRGBO(90, 90, 90, 1)),
          ),
          trailing: MediaQuery.of(context).size.width > 460
              ? FlatButton.icon(
                  textColor: Theme.of(context).errorColor,
                  label: const Text('Delete'),
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteTransaction(transaction),
                )
              : IconButton(
                  color: Theme.of(context).errorColor,
                  icon: const Icon(Icons.delete),
                  onPressed: () => deleteTransaction(transaction),
                ),
        ),
      ),
    );
  }
}