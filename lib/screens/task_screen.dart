import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/providers/TaskProvider.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';
import 'package:kompensasi_jti_mobile/widgets/navigationbar_component.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final tasks = ref.watch(taskProvider);

    if (tasks == null) {
      ref.read(taskProvider.notifier).getTasks();
    }

    Future<void> _refresh() async{
      await ref.read(taskProvider.notifier).getTasks();
    }

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: tasks == null
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
                          tasks.tasks.length.toString(),
                          style: MyTypography.title
                              .copyWith(color: MyColors.lightColor),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Tugas tersedia",
                          style: MyTypography.subTitle
                              .copyWith(color: MyColors.lightColor),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: _refresh,
                      child: ListView.builder(
                          itemCount: tasks.tasks.length,
                          itemBuilder: (context, index) {
                            final task = tasks.tasks[index];
                            return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/detail-task",
                                        arguments: {
                                          'id': task.id,
                                          'title': task.title,
                                          'description': task.description,
                                          'pengumpulan': task.typeOfAssignment,
                                          'deadline': task.deadline
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
                                          Icons.assignment,
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
                                                task.title,
                                                style: MyTypography.subTitle,
                                              ),
                                              Text(
                                                task.description,
                                                style: MyTypography.body,
                                                overflow: TextOverflow.visible,
                                              )
                                            ],
                                          ),
                                        ),
                                      ])),
                                ));
                          }),
                    ),
                  )
                ],
              ),
      )),
      bottomNavigationBar: NavigationBarComponent(index: 2),
    );
  }
}
