import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kompensasi_jti_mobile/providers/TaskProvider.dart';
import 'package:kompensasi_jti_mobile/themes/colors.dart';
import 'package:kompensasi_jti_mobile/themes/typography.dart';
import 'package:quickalert/quickalert.dart';

class DetailTaskScreen extends ConsumerStatefulWidget {
  const DetailTaskScreen({super.key});

  @override
  _DetailTaskScreenState createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends ConsumerState<DetailTaskScreen> {
  File? fileTugas;
  String? fileName;
  final TextEditingController urlTugas = TextEditingController();

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      debugPrint("File Picked: ${result!.files.single.name}");
      fileTugas = File(result.files.single.path!);
      final fileSize = await fileTugas!.length();
      const maxFileSize = 2 * 1024 * 1024;

      if (fileSize > maxFileSize) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("File size exceeds the maximum limit of 2 MB")),
        );
        setState(() {
          fileTugas = null;
          fileName = null;
        });
        return;
      }

      setState(() {
        fileName = result.files.single.name;
        debugPrint("File Name after setting state: $fileName");
      });
    }
  }

  Future<void> submitAssignment() async {
    bool submit;
    final task = ModalRoute.of(context)?.settings.arguments as Map?;

    if (task?['pengumpulan'] == "file") {
      if (fileTugas == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please choose a valid file to submit")),
        );
        return;
      }
      submit = await ref
          .read(taskProvider.notifier)
          .submitAssignment(idTask: task?['id'], file: fileTugas);
    } else {
      submit = await ref
          .read(taskProvider.notifier)
          .submitAssignment(idTask: task?['id'], assignment: urlTugas.text);
    }

    if (!submit) {
      print("Cannot submit task assignment");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cannot submit task assignment")),
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        text: 'Submit assignment successfully!',
        onConfirmBtnTap: () => Navigator.pushNamed(context, '/activity'),
        confirmBtnColor: MyColors.primaryColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = ModalRoute.of(context)?.settings.arguments as Map?;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Tugas"),
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
              Text(
                task?['title'] ?? "No Title",
                style: MyTypography.subTitle,
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              Text(
                task?['description'] ?? "No Description",
                style: MyTypography.body,
              ),
              const SizedBox(height: 18),
              const Text(
                "Pengumpulan",
                style: MyTypography.subTitle,
              ),
              const SizedBox(height: 12),
              task?['pengumpulan'] == "file"
                  ? GestureDetector(
                      onTap: pickFile,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: MyColors.backgroundColor,
                          border: Border.all(
                            color: MyColors.primaryColor.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.file_upload_outlined,
                              color: MyColors.primaryColor,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              fileName ??
                                  "Upload Document", // Menampilkan nama file jika ada
                              style: MyTypography.body.copyWith(
                                color: MyColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: MyColors.backgroundColor,
                        border: Border.all(
                          color: MyColors.primaryColor.withOpacity(0.5),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: urlTugas,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan URL Tugasmu",
                          contentPadding: EdgeInsets.symmetric(vertical: 3),
                        ),
                      ),
                    ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: submitAssignment,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: MyColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Submit",
                    textAlign: TextAlign.center,
                    style:
                        MyTypography.body.copyWith(color: MyColors.lightColor),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
