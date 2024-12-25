import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/providers/NotificationProvider.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final notifications = ref.watch(notificationProvider);

    if (notifications == null) {
      ref.read(notificationProvider.notifier).getNotifications();
    }

    Future<void> _refresh() async{
      await ref.read(notificationProvider.notifier).getNotifications();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: true,
        backgroundColor: MyColors.primaryColor,
        titleTextStyle:
            MyTypography.subTitle.copyWith(color: MyColors.lightColor),
        iconTheme: const IconThemeData(color: MyColors.lightColor),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: notifications == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: MyColors.primaryColor,
                ),
              )
            : Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                      itemCount: notifications.notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications.notifications[index];
                  
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: MyColors.backgroundColor,
                                border: Border.all(
                                    color: MyColors.primaryColor.withOpacity(0.5),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(notification.title,
                                    style: MyTypography.subTitle,
                                    overflow: TextOverflow.ellipsis),
                                Text(
                                  notification.time,
                                  style: MyTypography.body.copyWith(
                                      color: MyColors.darkColor.withOpacity(0.6)),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
      )),
    );
  }
}
