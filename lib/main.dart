import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/screens/activity_screen.dart';
import 'package:kompensasi_jti_mobile/screens/detail_kompensasi.dart';
import 'package:kompensasi_jti_mobile/screens/detail_task.dart';
import 'package:kompensasi_jti_mobile/screens/forgot_password_screen.dart';
import 'package:kompensasi_jti_mobile/screens/history_screen.dart';
import 'package:kompensasi_jti_mobile/screens/home_screen.dart';
import 'package:kompensasi_jti_mobile/screens/login_screen.dart';
import 'package:kompensasi_jti_mobile/screens/new_password_screen.dart';
import 'package:kompensasi_jti_mobile/screens/notification_screen.dart';
import 'package:kompensasi_jti_mobile/screens/profile_screen.dart';
import 'package:kompensasi_jti_mobile/screens/task_screen.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kompensasi JTI Polinema',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primaryColor),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/forgot-password': (context) => const ForgotPasswordScreen(),
        '/new-password': (context) => const NewPasswordScreen(),
        '/task': (context) => const TaskScreen(),
        '/detail-task': (context) => const DetailTaskScreen(),
        '/activity': (context) => const ActivityScreen(),
        '/history': (context) => const HistoryScreen(),
        '/detail-kompensasi': (context) => const DetailKompensasiScreen(),
        '/notification': (context) => const NotificationScreen()
      },
    );
  }
}
