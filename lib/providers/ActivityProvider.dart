import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/Activity.dart';
import 'package:kompensasi_jti_mobile/notifiers/ActivityNotifier.dart';

final activityProvider =
    StateNotifierProvider<ActivityNotifier, ActivitiesModel?>((ref) {
  return ActivityNotifier();
});
