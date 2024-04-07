class TaskModel {
  int? id;
  String? title;
  bool completed;

  TaskModel({required this.id, required this.title, this.completed = false});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? '',
      'title': title ?? '',
      'completed': completed,
    };
  }
}
