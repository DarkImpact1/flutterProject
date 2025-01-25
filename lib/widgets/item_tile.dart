import 'package:flutter/material.dart';
import '../models/item_model.dart';

class ItemTile extends StatelessWidget {
  final ItemModel item;

  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.title),
      // Optionally add subtitle or other info here if needed
    );
  }
}
