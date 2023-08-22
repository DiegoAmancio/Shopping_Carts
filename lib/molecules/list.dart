import 'package:flutter/material.dart';

import '../atoms/list_tab.dart';
import '../class/list_tab_item.dart';

class ListItemTabs extends StatelessWidget {
  final List<ListTabItem> items;

  const ListItemTabs({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (ctx, index) {
        final item = items[index];
        return ListTab(
          item: item,
        );
      },
    );
  }
}
