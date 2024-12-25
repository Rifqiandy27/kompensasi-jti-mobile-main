class TaskModel {
  final List<Task> tasks;

  TaskModel({
    required this.tasks,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      tasks: (json['data'] as List)
          .map((taskJson) => Task.fromJson(taskJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': tasks.map((task) => task.toJson()).toList(),
    };
  }
}

class Task {
  final int id;
  final String title;
  final String description;
  final String typeOfAssignment;
  final String deadline;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.typeOfAssignment,
    required this.deadline,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      typeOfAssignment: json['type_of_assignment'],
      deadline: json['deadline'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'type_of_assignment': typeOfAssignment,
      'deadline': deadline,
    };
  }
}