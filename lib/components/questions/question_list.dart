import 'package:flutter/material.dart';
import 'option_button.dart';

class QuestionList extends StatelessWidget {
  final List<String> questions;
  final String? selectedQuestion;
  final ValueChanged<String> onSelect;

  const QuestionList({
    super.key,
    required this.questions,
    required this.selectedQuestion,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final q = questions[index];
        final isSelected = selectedQuestion == q;
        return OptionButton(
          text: q,
          isSelected: isSelected,
          onTap: () => onSelect(q),
        );
      },
    );
  }
}
