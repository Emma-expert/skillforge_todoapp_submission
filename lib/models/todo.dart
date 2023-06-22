class Todo {
  int id;
  String title;
  String description;
  String status;
  DateTime? dueDate;
  bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.dueDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'duedate': dueDate,
      'status': status,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
      status: map['status'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}
