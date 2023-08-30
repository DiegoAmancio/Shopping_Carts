import 'package:flutter/material.dart';

import 'list_tab.dart';
import '../class/list_tab_item.dart';

class ListItemTabs extends StatelessWidget {
  final List<ListTabItem> items;
  final void Function(int id) onEdit;
  final void Function(int id) onRemove;

  const ListItemTabs(
      {super.key,
      required this.items,
      required this.onEdit,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, index) {
        final item = items[index];
        return ListTab(
          item: item,
          onEdit: onEdit,
          onRemove: onRemove,
        );
      },
    );
  }
}
