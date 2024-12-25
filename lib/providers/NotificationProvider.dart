import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/Notification.dart';
import 'package:kompensasi_jti_mobile/notifiers/NotificationNotifier.dart';

final notificationProvider = StateNotifierProvider<NotificationNotifier, NotificationModel?>((ref){
  return NotificationNotifier();
});
