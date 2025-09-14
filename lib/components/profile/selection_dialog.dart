// widgets/selection_dialog.dart
import 'package:flutter/material.dart';

class SelectionDialog extends StatelessWidget {
  final String title;
  final List<String> options;
  final Function(String) onSelected;

  const SelectionDialog({
    super.key,
    required this.title,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Divider(),
          ...options.map((option) {
            return ListTile(
              title: Text(option),
              onTap: () {
                onSelected(option);
                Navigator.pop(context);
              },
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
