import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/Activity.dart';
import 'package:kompensasi_jti_mobile/utils/dio_client.dart';

class ActivityNotifier extends StateNotifier<ActivitiesModel?> {
  final DioClient dioClient = DioClient();

  ActivityNotifier() : super(null) {
    getActivities();
  }

  Future<bool> getActivities() async {
    try {
      final response = await dioClient.dio.get('/requests-unfinished');

      if (response.data['status'] == 200) {
        final activities = response.data['data'];
        print(activities);
        final activity = ActivitiesModel.fromJson(activities);

        state = activity;
        return true;
      }

      state = null;
      return false;
    } catch (e) {
      print("Error get activities: $e");

      state = null;
      return false;
    }
  }
}
