import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/providers/ActivityProvider.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';
import 'package:kompensasi_jti_mobile/widgets/navigationbar_component.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final activities = ref.watch(activityProvider);

    if (activities == null) {
      ref.read(activityProvider.notifier).getActivities();
    }

    Future<void> _refresh() async {
      await ref.read(activityProvider.notifier).getActivities();
    }

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: activities == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: MyColors.primaryColor,
                ),
              )
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Text(
                          activities.numberOfUnfinishedRequests.toString(),
                          style: MyTypography.title
                              .copyWith(color: MyColors.lightColor),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Request yang belum selesai",
                          style: MyTypography.subTitle
                              .copyWith(color: MyColors.lightColor),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.builder(
                            itemCount: activities.unfinishedRequests.length,
                            itemBuilder: (context, index) {
                              final activity =
                                  activities.unfinishedRequests[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, "/detail-kompensasi",
                                        arguments: {
                                          "acc_dosen": activity.accDosen,
                                          "acc_kaprodi": activity.accKaprodi,
                                          "download_kompensasi":
                                              activity.downloadKompensasi,
                                          "komentar": activity.comments,
                                          "compensation_history": false
                                        });
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(12),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                              color: MyColors.primaryColor,
                                              width: 2)),
                                      child: Row(children: [
                                        const Icon(
                                          Icons.task,
                                          size: 28,
                                          color: MyColors.primaryColor,
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                activity.taskTitle,
                                                style: MyTypography.subTitle,
                                              ),
                                              Text(
                                                activity.taskDescription,
                                                style: MyTypography.body,
                                                overflow: TextOverflow.visible,
                                              )
                                            ],
                                          ),
                                        ),
                                      ])),
                                ),
                              );
                            }),
                      ))
                ],
              ),
      )),
      bottomNavigationBar: NavigationBarComponent(index: 3),
    );
  }
}
