import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:komdigi_logbooks_students/core/components/custom_date_picker.dart';
import 'package:komdigi_logbooks_students/core/core.dart';
import 'package:komdigi_logbooks_students/core/extensions/extensions.dart';
import 'package:komdigi_logbooks_students/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_students/main_page.dart';
import 'package:komdigi_logbooks_students/models/auth_response_model.dart';
import 'package:komdigi_logbooks_students/presentation/magang/bloc/get_internship/get_internship_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/progress/bloc/add_progress/add_progress_bloc.dart';

class UploadProgressPage extends StatefulWidget {
  const UploadProgressPage({super.key});

  @override
  State<UploadProgressPage> createState() => _UploadProgressPageState();
}

class _UploadProgressPageState extends State<UploadProgressPage> {
  User? user;
  String? uploadedFileName;
  late final TextEditingController namaController;
  late final TextEditingController pertemuanController;
  late final TextEditingController tanggalController;
  late final TextEditingController projectController;
  late final TextEditingController progressController;
  late final TextEditingController pembimbingController;

  String formatDate(DateTime date) {
    final dateFormatter = DateFormat('yyyy-MM-dd');
    return dateFormatter.format(date);
  }

  // Future<void> _initializeUserData() {
  //   final authData = AuthLocalDatasource().getAuthData();
  //   if (authData != null) {
  //     setState(() {
  //       user = authData.user;
  //     });
  //   }
  //   context
  //       .read<GetInternshipBloc>()
  //       .add(GetInternshipEvent.getInternship(id: user?.id));
  // }
  Future<void> _loadUserData() async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData != null) {
      setState(() {
        user = authData.user;
        print(user!.id);
      });
    }
    context
        .read<GetInternshipBloc>()
        .add(GetInternshipEvent.getInternship(id: user?.id));
  }

  @override
  void initState() {
    _loadUserData();
    namaController = TextEditingController();
    pertemuanController = TextEditingController();
    tanggalController = TextEditingController();
    projectController = TextEditingController();
    progressController = TextEditingController();
    pembimbingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Progress'),
      ),
      body: BlocConsumer<GetInternshipBloc, GetInternshipState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            success: (internships) {
              namaController.text = internships[0].id.toString();
              projectController.text = internships[0].project!.name!;
              pembimbingController.text = internships[0].supervisor!.name!;
            },
          );
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: namaController,
                    label: 'ID Magang',
                    readOnly: true,
                  ),
                  const SpaceHeight(16.0),
                  CustomTextField(
                    controller: pertemuanController,
                    label: 'Pertemuan Ke',
                  ),
                  const SpaceHeight(16.0),
                  CustomDatePicker(
                    label: 'Tanggal Bimbingan',
                    onDateSelected: (date) =>
                        tanggalController.text = formatDate(date).toString(),
                  ),
                  const SpaceHeight(16.0),
                  CustomTextField(
                    controller: projectController,
                    label: 'Project Yang Dikerjakan',
                    readOnly: true,
                  ),
                  const SpaceHeight(16.0),
                  CustomTextField(
                    controller: progressController,
                    label: 'Progress Anda',
                  ),
                  const SpaceHeight(16.0),
                  CustomTextField(
                    controller: pembimbingController,
                    label: 'Nama Pembimbing',
                    readOnly: true,
                  ),
                  const SpaceHeight(16.0),
                  Text('Upload Surat Permohonan Magang'),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );
                          if (result != null && result.files.isNotEmpty) {
                            setState(() {
                              uploadedFileName = result.files.single.path;
                            });
                          }
                        },
                        child: const Text('Upload'),
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          uploadedFileName ?? 'Belum ada file',
                          style: const TextStyle(
                              fontSize: 14.0, color: Colors.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SpaceHeight(32.0),
                  BlocConsumer<AddProgressBloc, AddProgressState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () {},
                        success: (progress) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Progress berhasil diupload'),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                          context.pushReplacement(const MainPage());
                        },
                        error: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor: AppColors.red,
                            ),
                          );
                          print(message);
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () {
                          return Button.filled(
                              onPressed: () {
                                if (uploadedFileName == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Harap upload file sebelum melanjutkan!'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                                context.read<AddProgressBloc>().add(
                                      AddProgressEvent.addProgress(
                                        internshipId:
                                            int.parse(namaController.text),
                                        meeting: pertemuanController.text,
                                        date: tanggalController.text,
                                        attachment: uploadedFileName != null
                                            ? File(uploadedFileName!)
                                            : null,
                                        progress: progressController.text,
                                      ),
                                    );
                              },
                              label: 'Upload Progress');
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
