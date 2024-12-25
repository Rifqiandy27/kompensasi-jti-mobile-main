import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/History.dart';
import 'package:kompensasi_jti_mobile/notifiers/HistoryNotifier.dart';

final historyProvider = StateNotifierProvider<HistoryNotifier, HistoryModel?>((ref){
  return HistoryNotifier();
});
