import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleInput = TextEditingController();
  final _amountInput = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitData() {
    final String enteredTitle = _titleInput.text;
    final String enteredAmount = _amountInput.text;

    if (enteredTitle.isEmpty || enteredAmount.isEmpty) {
      return;
    }

    widget.addTransaction(
      enteredTitle,
      double.parse(enteredAmount),
      _selectedDate == null ? DateTime.now() : _selectedDate,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Title'),
            controller: _titleInput,
            onSubmitted: (_) => _submitData(),
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount'),
            controller: _amountInput,
            onSubmitted: (_) => _submitData(),
            keyboardType: TextInputType.number,
          ),
          Row(
            children: [
              Expanded(
                child: Text(_selectedDate == null
                    ? 'Date: ' + DateFormat.yMMMEd().format(DateTime.now())
                    : 'Date: ' + DateFormat.yMMMEd().format(_selectedDate)),
              ),
              TextButton(
                onPressed: _presentDatePicker,
                child: Text('Choose Date'),
              )
            ],
          ),
          ElevatedButton(
            child: Text('Add Transaction'),
            onPressed: () {
              _submitData();
              print(_titleInput.text);
              print(_amountInput.text);
            },
          )
        ],
      ),
    );
  }
}
