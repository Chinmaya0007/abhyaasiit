// profile_page.dart
import 'dart:convert';
import 'package:abhyaasiit/components/profile/selection_dialog.dart';
import 'package:abhyaasiit/components/profile/selection_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import '../app_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> classes = [];
  List<String> boards = [];
  List<String> streams = [];

  @override
  void initState() {
    super.initState();
    _loadDummyData();
  }

  Future<void> _loadDummyData() async {
    final String response =
        await rootBundle.loadString('assets/curriculum.json');
    final data = json.decode(response);

    setState(() {
      classes = (data['classes'] as List).map((e) => "Class $e").toList();
      boards = List<String>.from(data['boards']);
      streams = List<String>.from(data['streams']);
    });
  }

  void _openDialog({
    required BuildContext context,
    required String title,
    required List<String> options,
    required Function(String) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SelectionDialog(
        title: title,
        options: options,
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF8F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Choose Subject",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Complete your profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Class
            SelectionTile(
              title: "Class",
              value: appState.selectedClass,
              onTap: () => _openDialog(
                context: context,
                title: "Select Class",
                options: classes,
                onSelected: (val) => appState.updateClass(val),
              ),
            ),

            // Board
            SelectionTile(
              title: "Board",
              value: appState.selectedBoard,
              onTap: () => _openDialog(
                context: context,
                title: "Select Board",
                options: boards,
                onSelected: (val) => appState.updateBoard(val),
              ),
            ),

            // Stream
            SelectionTile(
              title: "Stream (Optional)",
              value: appState.selectedStream,
              onTap: () => _openDialog(
                context: context,
                title: "Select Stream",
                options: streams,
                onSelected: (val) => appState.updateStream(val),
              ),
            ),

            const Spacer(),

            // Save Button
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (appState.selectedClass != null &&
                        appState.selectedBoard != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Profile saved!")),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please complete required fields."),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF8C42),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black26,
                  ),
                  child: const Text(
                    "Save & Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
