import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../class/list_tab_item.dart';

class ListTab extends StatelessWidget {
  final ListTabItem item;

  const ListTab({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(item.name),
        onTap: () {},
        trailing: Text(DateFormat('d/MM/y').format(item.date)),
      ),
    );
  }
}
