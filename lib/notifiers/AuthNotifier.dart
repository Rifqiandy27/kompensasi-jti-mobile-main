import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/models/User.dart';
import 'package:kompensasi_jti_mobile/utils/dio_client.dart';
import 'package:kompensasi_jti_mobile/utils/sharedprefs.dart';

class AuthNotifier extends StateNotifier<User?> {
  final DioClient dioClient = DioClient();
  final Sharedprefs prefs = Sharedprefs();

  AuthNotifier() : super(null);
  Future<bool> login(String username, String password) async {
    try {
      final response = await dioClient.dio.post(
        '/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.data['status'] == 200) {
        final token = response.data['data']['token'];
        final userData = response.data['data']['users'];

        print(token);

        await prefs.saveToken(token);

        final user = User.fromJson(userData);

        state = user;

        return true;
      }

      return false;
    } catch (e) {
      print("Login failed: $e");
      state = null;

      return false;
    }
  }

  Future<bool> logout() async {
    try {
      final response = await dioClient.dio.post(
        '/logout',
      );

      if (response.data['status'] == 200) {
        print(response.data['message']);
        await prefs.clearToken();
        state = null;
        return true;
      }

      return false;
    } catch (e) {
      print("Logout failed: $e");

      return false;
    }
  }

  Future<bool> sendEmailVerification(String email) async {
    try {
      final response = await dioClient.dio
          .post('/send-email-verification', data: {'email': email});

      if (response.data['status'] == 200) {
        print(response.data['message']);
        return true;
      }

      return false;
    } catch (e) {
      print("Logout failed: $e");

      return false;
    }
  }

  Future<bool> verifyCodeEmail(String code) async {
    try {
      final response = await dioClient.dio
          .post('/verify-code', data: {'verification_code': code});

      if (response.data['status'] == 200) {
        print(response.data['message']);
        return true;
      }

      return false;
    } catch (e) {
      print("Logout failed: $e");

      return false;
    }
  }

  Future<bool> resetPassword(
      String email, String code, String newPassword) async {
    try {
      final response = await dioClient.dio.post('/reset-password', data: {
        "email": email,
        "verification_code": code,
        "new_password": newPassword
      });

      if (response.data['status'] == 200) {
        print(response.data['message']);
        return true;
      }

      return false;
    } catch (e) {
      print("Logout failed: $e");

      return false;
    }
  }
}
