import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/providers/HistoryProvider.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';
import 'package:kompensasi_jti_mobile/widgets/navigationbar_component.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final histories = ref.watch(historyProvider);

    if (histories == null) {
      ref.read(historyProvider.notifier).getHistory();
    }

    Future<void> _refresh() async {
      await ref.read(historyProvider.notifier).getHistory();
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: histories == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: MyColors.primaryColor,
                  ),
                )
              : Column(children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: MyColors.primaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Text(
                          histories.numberOfFinishedRequests.toString(),
                          style: MyTypography.title
                              .copyWith(color: MyColors.lightColor),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "Request yang sudah selesai",
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
                        itemCount: histories.numberOfFinishedRequests,
                        itemBuilder: (context, index) {
                          final history = histories.finishedRequests[index];
                          
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, "/detail-kompensasi",
                                      arguments: {
                                        "acc_dosen": history.accDosen ?? '',
                                        "acc_kaprodi": history.accKaprodi,
                                        "download_kompensasi":
                                            history.downloadKompensasi,
                                        "komentar": history.comments,
                                        "compensation_history": true
                                      });
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(12),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: history.accDosen! == "terima" && history.accKaprodi! == "terima"
                                                ? MyColors.greenColor
                                                : MyColors.redColor,
                                            width: 2)),
                                    child: Row(children: [
                                      Icon(
                                        history.accDosen! == "terima" && history.accKaprodi! == "terima"
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        size: 28,
                                        color: history.accDosen! == "terima" && history.accKaprodi! == "terima"
                                            ? MyColors.greenColor
                                            : MyColors.redColor,
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
                                              history.taskTitle,
                                              style: MyTypography.subTitle,
                                            ),
                                            Text(
                                              history.taskDescription,
                                              style: MyTypography.body,
                                              overflow: TextOverflow.visible,
                                            )
                                          ],
                                        ),
                                      ),
                                    ])),
                              ));
                        }),
                  ))
                ]),
        ),
      ),
      bottomNavigationBar: NavigationBarComponent(index: 4),
    );
  }
}
