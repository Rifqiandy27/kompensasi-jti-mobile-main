class NotificationModel {
  final List<Notification> notifications;

  NotificationModel({
    required this.notifications,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notifications: (json['data'] as List)
          .map((notificationJson) => Notification.fromJson(notificationJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': notifications.map((notification) => notification.toJson()).toList(),
    };
  }
}

class Notification {
  final int id;
  final String title;
  final String time;

  Notification({
    required this.id,
    required this.title,
    required this.time,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      title: json['title'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'time': time,
    };
  }
}