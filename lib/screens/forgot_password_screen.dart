import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:kompensasi_jti_mobile/providers/AuthProvider.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';
import 'package:kompensasi_jti_mobile/widgets/button_component.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String textSendCode = "Send Code";
  Timer? _timer;
  int _start = 60;

  String _formatTime(int seconds) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(seconds ~/ 60);
    final secs = twoDigits(seconds % 60);
    return "$minutes:$secs";
  }

  void _sendCode() async {
    if (_timer != null && _timer!.isActive) return;
    setState(() {
      textSendCode = "01:00";
    });

    final sendEmail = await ref
        .read(authProvider.notifier)
        .sendEmailVerification(_emailController.text);

    if (!sendEmail) {
      print("Cannot send email to ${_emailController.text}");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to send verification code")),
      );
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Check your email for code verification")),
      );
    }

    _start = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
        setState(() {
          textSendCode = "Send Code";
        });
      } else {
        setState(() {
          _start--;
          textSendCode = _formatTime(_start);
        });
      }
    });

    print("Sending code to ${_emailController.text}");
  }

  void _verifyCode() async {
    final sendEmail = await ref
        .read(authProvider.notifier)
        .verifyCodeEmail(_codeController.text);

    if (!sendEmail) {
      print("Cannot send code verification");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to send code verification")),
      );
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Send code successfully")),
      );
      Navigator.pushNamed(context, '/new-password', arguments: {
        'email': _emailController.text,
        'verificationCode': _codeController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Forgot Password",
          style: MyTypography.button.copyWith(color: MyColors.lightColor),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: MyColors.lightColor),
        backgroundColor: MyColors.primaryColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your email to receive a verification code.",
                style: MyTypography.body.copyWith(color: MyColors.darkColor),
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: MyColors.lightColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter your email",
                      prefixIcon: const Icon(
                        TablerIcons.mail,
                        color: MyColors.primaryColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: TextButton(
                      onPressed: _sendCode,
                      style: TextButton.styleFrom(
                        backgroundColor: MyColors.primaryColor,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                      child: Text(textSendCode),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text("Enter the verification code sent to your email:",
                  style: MyTypography.body.copyWith(color: MyColors.darkColor)),
              const SizedBox(height: 20),
              TextField(
                controller: _codeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: MyColors.lightColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "Enter your verification code",
                  prefixIcon: const Icon(
                    TablerIcons.code,
                    color: MyColors.primaryColor,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                ),
              ),
              const SizedBox(height: 16),
              ButtonComponent(
                label: "Verify Code",
                onPressed: () async {
                  _verifyCode();
                },
                color: MyColors.primaryColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
