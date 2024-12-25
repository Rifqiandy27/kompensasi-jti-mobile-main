import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/providers/AuthProvider.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';
import 'package:kompensasi_jti_mobile/widgets/navigationbar_component.dart';
import 'package:quickalert/quickalert.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: MyTypography.subTitle.copyWith(color: MyColors.lightColor),
        ),
        centerTitle: true,
        backgroundColor: MyColors.primaryColor,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    border: Border.all(color: MyColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(92)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(92),
                  child: Image.network(
                    user!.image,
                    width: 92,
                    height: 92,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFieldComponent(
                        label: "Name", value: user.name, icon: Icons.person),
                    TextFieldComponent(
                        label: "Username",
                        value: user.username,
                        icon: Icons.account_box),
                    TextFieldComponent(
                        label: "Telp", value: user.telp, icon: Icons.phone),
                    TextFieldComponent(
                        label: "Semester",
                        value: '${user.semester}',
                        icon: Icons.school_rounded),
                    TextFieldComponent(
                        label: "Program Studi",
                        value: user.prodi,
                        icon: Icons.location_city_rounded),
                    TextFieldComponent(
                      label: "Address",
                      value: user.alamat,
                      icon: Icons.map,
                      alamat: true,
                    ),
                    GestureDetector(
                      onTap: () {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.confirm,
                          text: 'Do you want to logout?',
                          confirmBtnText: 'Yes',
                          cancelBtnText: 'No',
                          confirmBtnColor: MyColors.redColor,
                          cancelBtnTextStyle: MyTypography.button
                              .copyWith(color: MyColors.greenColor),
                          onConfirmBtnTap: () async {
                            bool status =
                                await ref.read(authProvider.notifier).logout();
                            if (status) Navigator.pushNamed(context, "/login");
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: MyColors.redColor.withOpacity(0.5),
                              border: Border.all(
                                  color: MyColors.redColor.withOpacity(0.8)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text("Logout",
                              textAlign: TextAlign.center,
                              style: MyTypography.body.copyWith(
                                color: Colors.white,
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      )),
      bottomNavigationBar: NavigationBarComponent(index: 5),
    );
  }
}

class TextFieldComponent extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final bool alamat;
  const TextFieldComponent(
      {super.key,
      required this.label,
      required this.value,
      required this.icon,
      this.alamat = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: MyTypography.body,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: MyColors.backgroundColor,
                border:
                    Border.all(color: MyColors.primaryColor.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              crossAxisAlignment:
                  alamat ? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: MyColors.primaryColor,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Text(
                    value,
                    overflow:
                        alamat ? TextOverflow.visible : TextOverflow.ellipsis,
                    maxLines: alamat ? 5 : 1,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
