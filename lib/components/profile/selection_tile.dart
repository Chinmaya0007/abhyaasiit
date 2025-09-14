// widgets/selection_tile.dart
import 'package:flutter/material.dart';

class SelectionTile extends StatelessWidget {
  final String title;
  final String? value;
  final VoidCallback onTap;

  const SelectionTile({
    super.key,
    required this.title,
    this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: ListTile(
        title: Text(value ?? title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
