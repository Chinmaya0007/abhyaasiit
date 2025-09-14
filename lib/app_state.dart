import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  // Profile selections
  String? selectedClass;
  String? selectedBoard;
  String? selectedStream;

  // Subject / Topic selections
  String? selectedSubjectId;
  String? selectedTopicId;

  // Update functions
  void updateClass(String value) {
    selectedClass = value;
    notifyListeners();
  }

  void updateBoard(String value) {
    selectedBoard = value;
    notifyListeners();
  }

  void updateStream(String? value) {
    selectedStream = value;
    notifyListeners();
  }

  void updateSubject(String subjectId) {
    selectedSubjectId = subjectId;
    selectedTopicId = null; // reset topic
    notifyListeners();
  }

  void updateTopic(String topicId) {
    selectedTopicId = topicId;
    notifyListeners();
  }
}
