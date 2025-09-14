
class Curriculum {
  final List<String> boards;
  final List<int> classes;
  final List<String> streams;
  final List<Subject> subjects;
  final List<Topic> topics;

  Curriculum({
    required this.boards,
    required this.classes,
    required this.streams,
    required this.subjects,
    required this.topics,
  });

  factory Curriculum.fromJson(Map<String, dynamic> json) {
    return Curriculum(
      boards: List<String>.from(json['boards']),
      classes: List<int>.from(json['classes']),
      streams: List<String>.from(json['streams']),
      subjects: (json['subjects'] as List)
          .map((s) => Subject.fromJson(s))
          .toList(),
      topics: (json['topics'] as List)
          .map((t) => Topic.fromJson(t))
          .toList(),
    );
  }
}

class Subject {
  final String id;
  final String name;

  Subject({required this.id, required this.name});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Topic {
  final String subjectId;
  final String title;
  final String description;

  Topic({
    required this.subjectId,
    required this.title,
    required this.description,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      subjectId: json['subjectId'],
      title: json['title'],
      description: json['description'],
    );
  }
}
