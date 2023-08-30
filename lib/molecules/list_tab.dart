import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../atoms/popup_card_menu.dart';
import '../class/list_tab_item.dart';

class ListTab extends StatelessWidget {
  final ListTabItem item;
  final void Function(int id) onEdit;
  final void Function(int id) onRemove;
  const ListTab(
      {super.key,
      required this.item,
      required this.onEdit,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(item.name),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/list',
            arguments: {'item': item},
          );
        },
        subtitle: Text(DateFormat('d/MM/y').format(item.date)),
        trailing: PopupCardMenu(
          item.id,
          onEdit: onEdit,
          onRemove: onRemove,
        ),
      ),
    );
  }
}
