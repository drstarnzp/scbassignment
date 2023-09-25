import 'dart:ffi';

class TodoList {
  int? pageNumber;
  int? totalPages;
  List<Task> tasks;

  TodoList({
    required this.pageNumber,
    required this.totalPages,
    required this.tasks,
  });

  factory TodoList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> tasks = json['tasks'];
    final int pageNumber = json['pageNumber'];
    final int totalPages = json['totalPages'];

    final List<Task> tasksItems =
    tasks.map((itemJson) => Task.fromJson(itemJson)).toList();

    return TodoList(tasks: tasksItems, pageNumber: pageNumber, totalPages: totalPages);
  }
}

class Task {
  String? id;
  String? title;
  String? description;
  String? createdAt;
  String? status;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.status,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: json['createdAt'],
      status: json['status']
    );
  }
}

