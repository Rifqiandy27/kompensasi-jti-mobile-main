class DashboardModel {
  final int numberOfTasks;
  final int numberOfRequests;
  final int numberOfRejectedRequests;
  final int numberOfFinishedRequests;
  final int numberOfProcessRequests;
  final List<Task> dataTasks;

  DashboardModel({
    required this.numberOfTasks,
    required this.numberOfRequests,
    required this.numberOfRejectedRequests,
    required this.numberOfFinishedRequests,
    required this.numberOfProcessRequests,
    required this.dataTasks,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      numberOfTasks: json['number_of_tasks'],
      numberOfRequests: json['number_of_requests'],
      numberOfRejectedRequests: json['number_of_rejected_requests'],
      numberOfFinishedRequests: json['number_of_finished_requests'],
      numberOfProcessRequests: json['number_of_proccess_requests'],
      dataTasks: (json['data_tasks'] as List)
          .map((taskJson) => Task.fromJson(taskJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number_of_tasks': numberOfTasks,
      'number_of_requests': numberOfRequests,
      'number_of_rejected_requests': numberOfRejectedRequests,
      'number_of_finished_requests': numberOfFinishedRequests,
      'number_of_proccess_requests': numberOfProcessRequests,
      'data_tasks': dataTasks.map((task) => task.toJson()).toList(),
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