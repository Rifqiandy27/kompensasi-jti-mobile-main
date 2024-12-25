import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/User.dart';

class ProfileNotifier extends StateNotifier<AsyncValue<User>>{
  ProfileNotifier() : super(const AsyncValue.loading());
}
