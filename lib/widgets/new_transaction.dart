import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleInput = TextEditingController();

  final amountInput = TextEditingController();

  void submitData() {
    final String enteredTitle = titleInput.text;
    final String enteredAmount = amountInput.text;

    if (enteredTitle.isEmpty || enteredAmount.isEmpty) {
      return;
    }

    widget.addTransaction(
      enteredTitle,
      double.parse(enteredAmount),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleInput,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountInput,
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
            ),
            TextButton(
              child: Text('Add Transaction'),
              onPressed: () {
                submitData();
                print(titleInput.text);
                print(amountInput.text);
              },
            )
          ],
        ),
      ),
    );
  }
}
