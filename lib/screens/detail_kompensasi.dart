import 'package:flutter/material.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailKompensasiScreen extends StatelessWidget {
  const DetailKompensasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final compensation = ModalRoute.of(context)?.settings.arguments as Map?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kompensasi"),
        centerTitle: true,
        backgroundColor: MyColors.primaryColor,
        titleTextStyle:
            MyTypography.subTitle.copyWith(color: MyColors.lightColor),
        iconTheme: const IconThemeData(color: MyColors.lightColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Compensation Tracking",
                style: MyTypography.body,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 40,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "Pengumpulan tugas",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: compensation?['acc_dosen'] == "terima"
                                ? Colors.green
                                : compensation?['acc_dosen'] == "tolak"
                                    ? MyColors.redColor
                                    : Colors.grey),
                      ),
                      Container(
                        width: 2,
                        height: 40,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "ACC Dosen",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: compensation?['acc_dosen'] == "terima"
                            ? Colors.black
                            : compensation?['acc_dosen'] == "tolak"
                                ? Colors.black
                                : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: compensation?['acc_kaprodi'] == "terima"
                              ? Colors.green
                              : compensation?['acc_kaprodi'] == "tolak"
                                  ? MyColors.redColor
                                  : Colors.grey,
                        ),
                      ),
                      Container(
                        width: 2,
                        height: 40,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "ACC Kaprodi",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: compensation?['acc_kaprodi'] == "terima"
                            ? Colors.black
                            : compensation?['acc_kaprodi'] == "tolak"
                                ? Colors.black
                                : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: compensation?['acc_kaprodi'] != null
                              ? MyColors.greenColor
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Finish",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: compensation?['acc_kaprodi'] != null
                            ? Colors.black
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                "File Kompensasi",
                style: MyTypography.body,
              ),
              const SizedBox(
                height: 12,
              ),
              compensation?['download_kompensasi'] == null ||
                      compensation?['compensation_history'] == false
                  ? const Text("No Compensation Available")
                  : compensation?['acc_kaprodi'] == "tolak"
                      ? const Text("Compensation rejected by Kaprodi")
                      : GestureDetector(
                          onTap: () async {
                            final Uri url =
                                Uri.parse(compensation?['download_kompensasi']);
                            if (!await launchUrl(url)) {
                              throw Exception('Could not launch $url');
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                color: MyColors.greenColor,
                                borderRadius: BorderRadius.circular(6)),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.download_rounded,
                                  size: 18,
                                  color: MyColors.lightColor,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "Download Kompensasi",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: MyColors.lightColor),
                                )
                              ],
                            ),
                          ),
                        ),
              compensation?['compensation_history']
                  ? Container()
                  : const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "Comments:",
                        style: MyTypography.body,
                      ),
                    ),
              compensation?['compensation_history']
                  ? Container()
                  : compensation?['komentar'].length <= 0
                      ? const Text("No Comments Available")
                      : Expanded(
                          child: ListView.builder(
                              itemCount: compensation?['komentar'].length,
                              itemBuilder: (context, index) {
                                final comment =
                                    compensation?['komentar'][index];
                                return Container(
                                  padding: const EdgeInsets.all(12),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: MyColors.backgroundColor,
                                      border: Border.all(
                                        color: MyColors.primaryColor
                                            .withOpacity(0.6),
                                      ),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(42.0),
                                        child: Image.network(
                                          comment['image'],
                                          width: 42,
                                          height: 42,
                                          fit: BoxFit.cover,
                                        ),
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
                                              comment['name'],
                                              style: MyTypography.body,
                                            ),
                                            const SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              comment['comment'],
                                              overflow: TextOverflow.visible,
                                              maxLines: 2,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }))
            ],
          ),
        ),
      ),
    );
  }
}
