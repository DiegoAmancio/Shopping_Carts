import 'package:flutter/material.dart';

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
        trailing: IconButton(
          icon: const Icon(Icons.zoom_out_map_outlined),
          color: Theme.of(context).colorScheme.error,
          onPressed: () {},
        ),
      ),
    );
  }
}
