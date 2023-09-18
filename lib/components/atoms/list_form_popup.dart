import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../class/list_tab_item.dart';

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
  bool _isButtonEnabled = false;

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _titleController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.initItem.name;
    _selectedDate = widget.initItem.date;
    _titleController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  _submitForm() {
    final name = _titleController.text;
    widget.onSubmit(
        ListTabItem(id: widget.initItem.id, name: name, date: _selectedDate));
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
                decoration: InputDecoration(labelText: 'name_of_list'.tr),
                textInputAction: TextInputAction.next,
                controller: _titleController,
                onFieldSubmitted: (_) {
                  _submitForm();
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _isButtonEnabled ? _submitForm : null,
                    child: Text(
                      'save'.tr,
                    ),
                  ),
                ],
              ),
            ])),
      ),
    );
  }
}
