import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/providers/AuthProvider.dart';
import 'package:kompensasi_jti_mobile/providers/DashboardProvider.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';
import 'package:kompensasi_jti_mobile/widgets/navigationbar_component.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final user = ref.watch(authProvider);
    final dashboard = ref.watch(dashboardProvider);

    if (dashboard == null) {
      ref.read(dashboardProvider.notifier).getDashboard();
    }

    Future<void> _refresh() async {
      await ref.read(dashboardProvider.notifier).getDashboard();
    }

    return Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Expanded(
                child: dashboard == null
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: MyColors.primaryColor,
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _refresh,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: MyColors.primaryColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(2),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          MyColors.lightColor,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          56.0)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(56.0),
                                                child: Image.network(
                                                  user!.image,
                                                  width: 56,
                                                  height: 56,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 175,
                                                  child: Text(
                                                    user!.name,
                                                    style: MyTypography.subTitle
                                                        .copyWith(
                                                            color: MyColors
                                                                .lightColor),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                                Text(
                                                  user.username,
                                                  style: MyTypography.body
                                                      .copyWith(
                                                          color: MyColors
                                                              .lightColor),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/notification");
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.only(right: 12),
                                            child: Icon(
                                              Icons.notifications,
                                              size: 38,
                                              color: MyColors.lightColor,
                                            ),
                                          ),
                                        ),
                                      ])),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: MyColors.secondColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.task,
                                                size: 32,
                                                color: MyColors.lightColor,
                                              ),
                                              Text(
                                                dashboard.numberOfTasks
                                                    .toString(),
                                                style: MyTypography.title
                                                    .copyWith(
                                                        color: MyColors
                                                            .lightColor),
                                              ),
                                            ],
                                          ),
                                          Text('Total Tasks',
                                              style: MyTypography.body.copyWith(
                                                  color: MyColors.lightColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: MyColors.secondColor,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.request_page,
                                                size: 32,
                                                color: MyColors.lightColor,
                                              ),
                                              Text(
                                                dashboard.numberOfRequests
                                                    .toString(),
                                                style: MyTypography.title
                                                    .copyWith(
                                                        color: MyColors
                                                            .lightColor),
                                              ),
                                            ],
                                          ),
                                          Text('Total Requests',
                                              style: MyTypography.body.copyWith(
                                                  color: MyColors.lightColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: MyColors.secondColor,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.check_circle,
                                                size: 32,
                                                color: MyColors.lightColor,
                                              ),
                                              Text(
                                                dashboard
                                                    .numberOfFinishedRequests
                                                    .toString(),
                                                style: MyTypography.title
                                                    .copyWith(
                                                        color: MyColors
                                                            .lightColor),
                                              ),
                                            ],
                                          ),
                                          Text('Requests Approved',
                                              style: MyTypography.body.copyWith(
                                                  color: MyColors.lightColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: MyColors.secondColor,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.cancel,
                                                size: 32,
                                                color: MyColors.lightColor,
                                              ),
                                              Text(
                                                dashboard
                                                    .numberOfRejectedRequests
                                                    .toString(),
                                                style: MyTypography.title
                                                    .copyWith(
                                                        color: MyColors
                                                            .lightColor),
                                              ),
                                            ],
                                          ),
                                          Text('Requests Rejected',
                                              style: MyTypography.body.copyWith(
                                                  color: MyColors.lightColor)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Text(
                                "New tasks",
                                style: MyTypography.subTitle,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Expanded(
                                  child: ListView.builder(
                                      itemCount: dashboard.dataTasks.length,
                                      itemBuilder: (context, index) {
                                        final task = dashboard.dataTasks[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, "/detail-task",
                                                  arguments: {
                                                    'id': task.id,
                                                    'title': task.title,
                                                    'description':
                                                        task.description,
                                                    'pengumpulan':
                                                        task.typeOfAssignment,
                                                    'deadline': task.deadline
                                                  });
                                            },
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    border: Border.all(
                                                        color: MyColors
                                                            .primaryColor,
                                                        width: 2)),
                                                child: Row(children: [
                                                  const Icon(
                                                    Icons.assignment,
                                                    size: 28,
                                                    color:
                                                        MyColors.primaryColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 12,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          task.title,
                                                          style: MyTypography
                                                              .subTitle,
                                                        ),
                                                        Text(
                                                          task.description,
                                                          style:
                                                              MyTypography.body,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ])),
                                          ),
                                        );
                                      }))
                            ]),
                      ),
              ))),
      bottomNavigationBar: NavigationBarComponent(index: 1),
    );
  }
}
