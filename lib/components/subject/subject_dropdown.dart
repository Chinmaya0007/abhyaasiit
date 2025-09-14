import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';

class SubjectDropdown extends StatelessWidget {
  final List<Map<String, dynamic>> subjects;

  const SubjectDropdown({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Subject",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1c140d),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: state.selectedSubjectId,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          hint: const Text("Choose a subject"),
          items: subjects.map((subject) {
            return DropdownMenuItem<String>(
              value: subject['id'] as String,
              child: Text(subject['name'] as String),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              state.updateSubject(value);
            }
          },
        ),
      ],
    );
  }
}
