import 'dart:convert';
import 'package:abhyaasiit/components/subject/app_header.dart';
import 'package:abhyaasiit/components/subject/continue_button.dart';
import 'package:abhyaasiit/components/subject/subject_dropdown.dart';
import 'package:abhyaasiit/components/subject/topic_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'package:abhyaasiit/pages/questions_page.dart';
import '../app_state.dart';

class SelectSubjectPage extends StatefulWidget {
  const SelectSubjectPage({super.key});

  @override
  State<SelectSubjectPage> createState() => _SelectSubjectPageState();
}

class _SelectSubjectPageState extends State<SelectSubjectPage> {
  List<Map<String, dynamic>> subjects = [];
  List<Map<String, dynamic>> topics = [];

  @override
  void initState() {
    super.initState();
    _loadDummyData();
  }

  Future<void> _loadDummyData() async {
    final String response = await rootBundle.loadString(
      'assets/curriculum.json',
    );
    final data = json.decode(response);

    setState(() {
      subjects = List<Map<String, dynamic>>.from(data['subjects']);
      topics = List<Map<String, dynamic>>.from(data['topics']);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    final filteredTopics = state.selectedSubjectId == null
        ? <Map<String, dynamic>>[]
        : topics
              .where((t) => t['subjectId'] == state.selectedSubjectId)
              .cast<Map<String, dynamic>>() // 👈 force cast here
              .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFfcfaf8),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              const AppHeader(), // 🔹 Logo + Title

              const SizedBox(height: 24),
              const Text(
                "Select Subject and Topic",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1c140d),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              SubjectDropdown(subjects: subjects), // 🔹 Subject dropdown
              const SizedBox(height: 24),
              TopicDropdown(topics: filteredTopics), // 🔹 Topic dropdown

              const Spacer(),

              ContinueButton(
                // 🔹 Continue button
                isEnabled:
                    state.selectedSubjectId != null &&
                    state.selectedTopicId != null,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          QuestionScreen(topicId: state.selectedTopicId!),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
