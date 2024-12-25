import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/Task.dart';
import 'package:kompensasi_jti_mobile/utils/dio_client.dart';

class TaskNotifier extends StateNotifier<TaskModel?> {
  final DioClient dioClient = DioClient();

  TaskNotifier() : super(null) {
    getTasks();
  }

  Future<bool> getTasks() async {
    try {
      final response = await dioClient.dio.get('/tasks');

      if (response.data['status'] == 200) {
        final tasksData = response.data['data'] as List<dynamic>;
        final data = TaskModel(
            tasks:
                tasksData.map((taskJson) => Task.fromJson(taskJson)).toList());

        state = data;

        return true;
      }
      state = null;
      return false;
    } catch (e) {
      print("Error get tasks: $e");
      state = null;
      return false;
    }
  }

  Future<bool> submitAssignment(
      {required int idTask, String? assignment, File? file}) async {
    try {
      FormData formData = FormData();

      if (file != null) {
        formData.fields.add(MapEntry("id_task", idTask.toString()));
        formData.files.add(MapEntry(
            "assignment",
            await MultipartFile.fromFile(file.path,
                filename: file.uri.pathSegments.last)));
      }

      if (assignment != null && file == null) {
        formData.fields.add(MapEntry("id_task", idTask.toString()));
        formData.fields.add(MapEntry("assignment", assignment));
      }

      final response =
          await dioClient.dio.post("/submission-task", data: formData);

      if (response.data['status'] == 200) {
        print("Send data assignment successfully");

        return true;
      }

      return false;
    } catch (e) {
      print("Error submit assignment: $e");
      return false;
    }
  }
}
