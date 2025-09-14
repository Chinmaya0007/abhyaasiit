import 'dart:convert';
import 'package:abhyaasiit/components/questions/header_section.dart';
import 'package:abhyaasiit/components/questions/logout_button.dart';
import 'package:abhyaasiit/components/questions/question_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class QuestionScreen extends StatefulWidget {
  final String topicId; // e.g., "t1"

  const QuestionScreen({super.key, required this.topicId});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  String topicTitle = "";
  List<String> questions = [];
  String? selectedQuestion;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final String response =
        await rootBundle.loadString('assets/curriculum.json');
    final data = json.decode(response);

    final topics = List<Map<String, dynamic>>.from(data['topics']);
    final topic = topics.firstWhere(
      (t) => t['id'] == widget.topicId,
      orElse: () => {"title": "Unknown Topic"},
    );

    final allQuestions = List<Map<String, dynamic>>.from(data['questions']);
    final topicQuestions = allQuestions.firstWhere(
      (q) => q['topicId'] == widget.topicId,
      orElse: () => {"items": ["No questions available"]},
    );

    setState(() {
      topicTitle = topic['title'] ?? "Unknown Topic";
      questions = List<String>.from(topicQuestions['items']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFAF8),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const HeaderSection(), // 🔹 Extracted header

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                topicTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // 🔹 Extracted Question List
            Expanded(
              child: QuestionList(
                questions: questions,
                selectedQuestion: selectedQuestion,
                onSelect: (q) {
                  setState(() {
                    selectedQuestion = q;
                  });
                },
              ),
            ),

            // 🔹 Extracted Logout Button
            LogoutButton(onLogout: () => _showLogoutDialog(context)),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: const Text(
            "Are you sure you want to log out?",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.orange, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                "No",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // TODO: navigate back to login
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                "Yes",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
