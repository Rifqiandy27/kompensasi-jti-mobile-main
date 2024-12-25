import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/Task.dart';
import 'package:kompensasi_jti_mobile/notifiers/TaskNotifier.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, TaskModel?>((ref){
  return TaskNotifier();
});
