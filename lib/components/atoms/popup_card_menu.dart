import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopupCardMenu extends StatelessWidget {
  final int id;
  final void Function(int id) onEdit;
  final void Function(int id) onRemove;

  const PopupCardMenu(this.id,
      {super.key, required this.onEdit, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            PopupMenuItem<int>(
              value: 0,
              child: Text('edit'.tr),
            ),
            PopupMenuItem<int>(
              value: 1,
              child: Text('remove'.tr),
            ),
          ];
        },
        onSelected: (value) {
          if (value == 0) {
            onEdit(id);
          } else if (value == 1) {
            onRemove(id);
          }
        });
  }
}
