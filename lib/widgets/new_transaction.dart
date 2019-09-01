import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedDate = DateTime.now();

  void _submitData() {
    final title = _titleController.text;
    final amount = _amountController.text;

    if (title.isEmpty || amount.isEmpty || _selectedDate == null) {
      return;
    }

    widget.addTransaction(title, double.parse(amount), _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            lastDate: DateTime.now().add(Duration(hours: 1)),
            firstDate: DateTime(2019),
            initialDate: DateTime.now())
        .then((chosenDate) {
      if (chosenDate != null) {
        setState(() {
          _selectedDate = chosenDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 60,
              child: Row(
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? "No Date chosen"
                        : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      "Choose date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            FlatButton(
              color: Theme.of(context).primaryColor,
              child: Text('Add transaction'),
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }
}
