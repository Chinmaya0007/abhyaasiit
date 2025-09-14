import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_state.dart';

class TopicDropdown extends StatelessWidget {
  final List<Map<String, dynamic>> topics;

  const TopicDropdown({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Topic",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1c140d),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: state.selectedTopicId,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          hint: Text(state.selectedSubjectId == null
              ? "Select a subject first"
              : "Choose a topic"),
          items: topics.map((topic) {
            return DropdownMenuItem<String>(
              value: topic['id'] as String,
              child: Text(topic['title'] as String),
            );
          }).toList(),
          onChanged: state.selectedSubjectId == null
              ? null
              : (value) {
                  if (value != null) {
                    state.updateTopic(value);
                  }
                },
        ),
      ],
    );
  }
}
