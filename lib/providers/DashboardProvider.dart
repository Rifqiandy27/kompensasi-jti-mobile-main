import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/Dashboard.dart';
import 'package:kompensasi_jti_mobile/notifiers/DashboardNotifier.dart';

final dashboardProvider = StateNotifierProvider<DashboardNotifier, DashboardModel?>((ref){
  return DashboardNotifier();
});
