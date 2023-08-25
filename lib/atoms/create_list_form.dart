import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateListForm extends StatefulWidget {
  final void Function(String, DateTime) onSubmit;
  const CreateListForm(this.onSubmit, {super.key});

  @override
  State<CreateListForm> createState() => _CreateListFormState();
}

class _CreateListFormState extends State<CreateListForm> {
  final _titleController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  _submitForm() {
    final name = _titleController.text;
    widget.onSubmit(name, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(children: [
              TextField(
                  decoration: const InputDecoration(labelText: 'Nome'),
                  controller: _titleController),
              SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Data Selecionada'),
                        Text(DateFormat('d/M/y').format(_selectedDate)),
                      ],
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: const Text(
                        'Selecionar data',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _titleController.value.text.isEmpty
                        ? null
                        : _submitForm,
                    child: Text(
                      'Nova Lista',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.labelLarge?.color,
                      ),
                    ),
                  ),
                ],
              ),
            ])),
      ),
    );
  }
}
