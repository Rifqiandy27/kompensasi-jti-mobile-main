import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/Dashboard.dart';
import 'package:kompensasi_jti_mobile/utils/dio_client.dart';

class DashboardNotifier extends StateNotifier<DashboardModel?> {
  final DioClient dioClient = DioClient();

  DashboardNotifier() : super(null) {
    getDashboard();
  }

  Future<bool> getDashboard() async {
    try {
      final response = await dioClient.dio.get('/student-dashboard');

      if (response.data['status'] == 200) {
        final dashboardData = response.data['data'];
        final data = DashboardModel.fromJson(dashboardData);

        state = data;

        return true;
      }
      state = null;
      return false;
    } catch (e) {
      print("Error get data dashboard: $e");
      state = null;
      return false;
    }
  }
}
