import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/History.dart';
import 'package:kompensasi_jti_mobile/utils/dio_client.dart';

class HistoryNotifier extends StateNotifier<HistoryModel?> {
  final DioClient dioClient = DioClient();

  HistoryNotifier() : super(null) {
    getHistory();
  }

  Future<bool> getHistory() async {
    try {
      final response = await dioClient.dio.get('/requests-finished');

      if (response.data['status'] == 200) {
        final histories = response.data['data'];
        final history = HistoryModel.fromJson(histories);

        state = history;
        return true;
      }

      state = null;
      return false;
    } catch (e) {
      print("Error get history: $e");
      state = null;
      return false;
    }
  }
}
