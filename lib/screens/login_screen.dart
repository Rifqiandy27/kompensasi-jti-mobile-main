import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/providers/AuthProvider.dart';
import 'package:kompensasi_jti_mobile/providers/VisibilityProvider.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:kompensasi_jti_mobile/widgets/button_component.dart';
import 'package:quickalert/quickalert.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.warning,
        text: 'Please enter your username and password!',
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    bool status = await ref.read(authProvider.notifier).login(
          usernameController.text,
          passwordController.text,
        );

    setState(() {
      isLoading = false;
    });

    if (status) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Login successfully!',
        onConfirmBtnTap: () => Navigator.pushNamed(context, '/dashboard'),
        confirmBtnColor: MyColors.primaryColor,
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Oops...",
        text: 'Username/Password is wrong!',
        confirmBtnColor: MyColors.redColor,
      );
    }
  }

  void handleForgotPassword() {
    Navigator.pushNamed(context, '/forgot-password');
  }

  void handlePasswordVisibility() {
    final visibilityNotifier = ref.read(iconVisibilityProvider.notifier);
    visibilityNotifier.state = !visibilityNotifier.state;
    debugPrint("Password Visibility: ${!visibilityNotifier.state}");
  }

  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = ref.watch(iconVisibilityProvider);

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/logo_polinema.png',
                          width: 120, height: 120),
                      const SizedBox(height: 8),
                      Text(
                        "Welcome Back",
                        style: MyTypography.title.copyWith(
                            color: MyColors.primaryColor,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Log in to your account",
                        style: MyTypography.subTitle.copyWith(
                          color: MyColors.darkColor.withOpacity(0.6),
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Text(
                  "Username",
                  style: MyTypography.body.copyWith(color: MyColors.darkColor),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyColors.lightColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Enter your username",
                    prefixIcon: const Icon(
                      TablerIcons.user,
                      color: MyColors.primaryColor,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "Password",
                  style: MyTypography.body.copyWith(color: MyColors.darkColor),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: passwordController,
                  obscureText: isPasswordVisible,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: MyColors.lightColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "Enter your password",
                    prefixIcon: const Icon(
                      TablerIcons.lock,
                      color: MyColors.primaryColor,
                    ),
                    suffixIcon: IconButton(
                        onPressed: handlePasswordVisibility,
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: MyColors.greyColor,
                        )),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 20),
                ButtonComponent(
                  label: 'Login',
                  onPressed: isLoading ? null : handleLogin,
                  color: MyColors.primaryColor,
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: handleForgotPassword,
                    child: Text(
                      "Forgot Password?",
                      style: MyTypography.body.copyWith(
                        color: MyColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                if (isLoading) ...[
                  const Center(child: CircularProgressIndicator()),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
