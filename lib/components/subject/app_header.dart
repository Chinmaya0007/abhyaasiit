import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(Icons.school, size: 100, color: Colors.orange),
        SizedBox(height: 16),
        Text(
          "AbhyaasIIT",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFFf57c00),
          ),
        ),
      ],
    );
  }
}
