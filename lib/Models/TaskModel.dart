class Task {
  final int id;
  final String title;
  final String description;
  final DateTime previsionTask;
  final DateTime? createdAt;
  final DateTime? finishAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.previsionTask,
    this.createdAt,
    this.finishAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'previsionTask': previsionTask.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'finishAt': finishAt?.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      previsionTask: DateTime.parse(map['previsionTask']),
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      finishAt: map['finishAt'] != null ? DateTime.parse(map['finishAt']) : null,
    );
  }
}
