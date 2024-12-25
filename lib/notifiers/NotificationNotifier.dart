import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/Notification.dart';
import 'package:kompensasi_jti_mobile/utils/dio_client.dart';

class NotificationNotifier extends StateNotifier<NotificationModel?> {
  final DioClient dioClient = DioClient();

  NotificationNotifier() : super(null) {
    getNotifications();
  }

  Future<bool> getNotifications() async {
    try {
      final response = await dioClient.dio.get('/notifications');

      if (response.data['status'] == 200) {
        final notifications = response.data['data'] as List<dynamic>;
        final notification = NotificationModel(
          notifications: notifications
              .map((notification) => Notification.fromJson(notification))
              .toList(),
        );

        state = notification;
        return true;
      }

      state = null;
      return false;
    } catch (e) {
      print("Error get notifications: $e");
      state = null;
      return false;
    }
  }
}
