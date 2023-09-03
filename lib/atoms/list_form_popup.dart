import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../class/list_tab_item.dart';
import '../utils/validations.dart';

class ListFormPopup extends StatefulWidget {
  final ListTabItem initItem;
  final void Function(ListTabItem item) onSubmit;
  const ListFormPopup(this.onSubmit, {super.key, required this.initItem});

  @override
  State<ListFormPopup> createState() => _ListFormPopupState();
}

class _ListFormPopupState extends State<ListFormPopup> {
  final _titleController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initItem.name;
    _selectedDate = widget.initItem.date;
  }

  _submitForm() {
    final name = _titleController.text;
    widget.onSubmit(
        ListTabItem(id: widget.initItem.id, name: name, date: _selectedDate));
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
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome da lista'),
                textInputAction: TextInputAction.next,
                controller: _titleController,
                autofocus: true,
                validator: (value) {
                  return validatorInputs(value);
                },
                onFieldSubmitted: (_) {
                  _submitForm();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _titleController.value.text.isEmpty
                        ? null
                        : _submitForm,
                    child: Text(
                      'Salvar',
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
