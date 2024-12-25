import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:kompensasi_jti_mobile/providers/AuthProvider.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';
import 'package:kompensasi_jti_mobile/widgets/button_component.dart';
import 'package:quickalert/quickalert.dart';

class NewPasswordScreen extends ConsumerStatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  ConsumerState<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends ConsumerState<NewPasswordScreen> {
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmationNewPassword =
      TextEditingController();

  String? email;
  String? verificationCode;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    if (arguments != null) {
      email = arguments['email'];
      verificationCode = arguments['verificationCode'];
    }
  }

  void _handleResetPassword() async {
    if (_newPassword.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 8 characters")),
      );
      return;
    }

    if (_newPassword.text != _confirmationNewPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text("Your new password and confirmation password not match")),
      );
      return;
    }

    if (email == null || verificationCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Missing email or verification code")),
      );
      return;
    }

    final resetPassword = await ref
        .read(authProvider.notifier)
        .resetPassword(email!, verificationCode!, _newPassword.text);

    if (!resetPassword) {
      print("Cannot reset password");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot reset password")),
      );
      return;
    } else {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          text: 'Reset password successfully!',
          onConfirmBtnTap: () => Navigator.pushNamed(context, '/login'),
          confirmBtnColor: MyColors.primaryColor);
    }

    print("Reset Password Now!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Reset Password",
          style: MyTypography.button.copyWith(color: MyColors.lightColor),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: MyColors.lightColor),
        backgroundColor: MyColors.primaryColor,
      ),
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Password",
              style: MyTypography.body.copyWith(color: MyColors.darkColor),
            ),
            TextField(
              controller: _newPassword,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: MyColors.lightColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: "Enter New Password",
                  prefixIcon: const Icon(
                    TablerIcons.lock,
                    color: MyColors.primaryColor,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12)),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Confirmation New Password",
              style: MyTypography.body.copyWith(color: MyColors.darkColor),
            ),
            TextField(
              controller: _confirmationNewPassword,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: MyColors.lightColor,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: "Enter Confirmation New Password",
                  prefixIcon: const Icon(
                    TablerIcons.lock,
                    color: MyColors.primaryColor,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12)),
            ),
            const SizedBox(
              height: 16,
            ),
            ButtonComponent(
              label: 'Reset Password',
              onPressed: () async {
                _handleResetPassword();
              },
              color: MyColors.primaryColor,
            )
          ],
        ),
      )),
    );
  }
}
