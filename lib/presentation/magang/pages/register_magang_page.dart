import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_students/core/core.dart';
import 'package:komdigi_logbooks_students/core/extensions/build_context_ext.dart';
import 'package:komdigi_logbooks_students/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_students/models/auth_response_model.dart';
import 'package:komdigi_logbooks_students/presentation/magang/bloc/add_internship/add_internship_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/magang/bloc/get_pembimbing/get_pembimbing_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/magang/widgets/success_registration_page.dart';
import 'package:komdigi_logbooks_students/presentation/project/bloc/get_project/get_project_bloc.dart';

class RegisterMagangPage extends StatefulWidget {
  const RegisterMagangPage({super.key});

  @override
  State<RegisterMagangPage> createState() => _RegisterMagangPageState();
}

class _RegisterMagangPageState extends State<RegisterMagangPage> {
  User? user;
  late final TextEditingController ketuacontroller;
  late final TextEditingController anggotacontroller;
  late final TextEditingController anggotaDuacontroller;
  late final TextEditingController anggotaTigacontroller;
  late final TextEditingController anggotaEmpatcontroller;
  late final TextEditingController anggotaLimacontroller;
  late final TextEditingController namaKampuscontroller;
  late final TextEditingController emailcontroller;
  String? selectedProject;
  String? selectedSupervisor;
  String? uploadedFileName;
  String? uploadedFilePhotoName;

  Future<void> _loadUserData() async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData != null) {
      setState(() {
        user = authData.user;
        ketuacontroller.text = user!.email ?? '';
        print(user!.id);
      });
    }
  }

  @override
  void initState() {
    _loadUserData();
    ketuacontroller = TextEditingController();
    anggotacontroller = TextEditingController();
    anggotaDuacontroller = TextEditingController();
    anggotaTigacontroller = TextEditingController();
    anggotaEmpatcontroller = TextEditingController();
    anggotaLimacontroller = TextEditingController();
    namaKampuscontroller = TextEditingController();
    emailcontroller = TextEditingController();
    context.read<GetProjectBloc>().add(const GetProjectEvent.getProject());
    context
        .read<GetPembimbingBloc>()
        .add(const GetPembimbingEvent.getPembimbing());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Magang'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: ketuacontroller,
                label: 'Email Ketua',
              ),
              SpaceHeight(16.0),
              CustomTextField(
                controller: anggotacontroller,
                label: 'Email Anggota 1',
              ),
              SpaceHeight(16.0),
              CustomTextField(
                controller: anggotaDuacontroller,
                label: 'Email Anggota 2',
              ),
              SpaceHeight(16.0),
              CustomTextField(
                controller: anggotaTigacontroller,
                label: 'Email Anggota 3',
              ),
              SpaceHeight(16.0),
              CustomTextField(
                controller: anggotaEmpatcontroller,
                label: 'Email Anggota 4',
              ),
              SpaceHeight(16.0),
              CustomTextField(
                controller: anggotaLimacontroller,
                label: 'Email Anggota 5',
              ),
              SpaceHeight(16.0),
              CustomTextField(
                controller: namaKampuscontroller,
                label: 'Nama Kampus',
              ),
              SpaceHeight(16.0),
              BlocConsumer<GetProjectBloc, GetProjectState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (projects) {
                      if (projects.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data tidak tersedia'),
                          ),
                        );
                      }
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    success: (projects) {
                      final items = projects
                          .map((project) => DropdownMenuItem<String>(
                                value: project.id.toString(),
                                child: Text(project.name ?? 'Tidak ada nama'),
                              ))
                          .toList();
                      return SizedBox(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          value: selectedProject,
                          hint: const Text('Pilih Project'),
                          items: items,
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              selectedProject = value!;
                            });
                          },
                        ),
                      );
                    },
                    orElse: () => const Text('Data tidak tersedia'),
                  );
                },
              ),
              SpaceHeight(16.0),
              BlocConsumer<GetPembimbingBloc, GetPembimbingState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (pembimbing) {
                      if (pembimbing.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data tidak tersedia'),
                          ),
                        );
                      }
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    success: (pembimbing) {
                      final items = pembimbing
                          .map((pembimbing) => DropdownMenuItem<String>(
                                value: pembimbing.id.toString(),
                                child:
                                    Text(pembimbing.name ?? 'Tidak ada nama'),
                              ))
                          .toList();
                      return SizedBox(
                        width: double.infinity,
                        child: DropdownButton<String>(
                          value: selectedSupervisor,
                          hint: const Text('Pilih Pembimbing'),
                          items: items,
                          isExpanded: true,
                          onChanged: (value) {
                            setState(() {
                              selectedSupervisor = value!;
                            });
                          },
                        ),
                      );
                    },
                    orElse: () => const Text('Data tidak tersedia'),
                  );
                },
              ),
              SpaceHeight(16.0),
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
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SpaceHeight(16.0),
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
                          uploadedFilePhotoName = result.files.single.path;
                        });
                      }
                    },
                    child: const Text('Upload'),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      uploadedFilePhotoName ?? 'Belum ada file',
                      style:
                          const TextStyle(fontSize: 14.0, color: Colors.grey),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SpaceHeight(16.0),
              BlocConsumer<AddInternshipBloc, AddInternshipState>(
                listener: (context, state) {
                  state.maybeWhen(
                    orElse: () {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
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
                    success: (data) {
                      ketuacontroller.clear();
                      anggotacontroller.clear();
                      anggotaDuacontroller.clear();
                      anggotaTigacontroller.clear();
                      anggotaEmpatcontroller.clear();
                      anggotaLimacontroller.clear();
                      namaKampuscontroller.clear();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Berhasil mendaftar magang'),
                        ),
                      );
                      context.push(const SuccessRegistrationPage());
                    },
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () {
                      return Button.filled(
                          onPressed: () {
                            if (uploadedFileName == null ||
                                uploadedFilePhotoName == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Harap upload semua file yang diperlukan'),
                                ),
                              );
                              return;
                            }
                            final letterFile = File(uploadedFileName!);
                            final memberPhotoFile =
                                File(uploadedFilePhotoName!);
                            if (!letterFile.existsSync() ||
                                !memberPhotoFile.existsSync()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'File tidak ditemukan. Harap pilih ulang file.'),
                                ),
                              );
                              return;
                            }
                            context.read<AddInternshipBloc>().add(
                                  AddInternshipEvent.addInternship(
                                    emailLeader: ketuacontroller.text,
                                    projectId:
                                        int.parse(selectedProject ?? '0'),
                                    supervisorId:
                                        int.parse(selectedSupervisor ?? '0'),
                                    letterUrl: uploadedFileName != null
                                        ? File(uploadedFileName!)
                                        : File(''),
                                    memberPhotoUrl:
                                        uploadedFilePhotoName != null
                                            ? File(uploadedFilePhotoName!)
                                            : File(''),
                                    memberEmails: [
                                      if (anggotacontroller.text.isNotEmpty)
                                        anggotacontroller.text,
                                      if (anggotaDuacontroller.text.isNotEmpty)
                                        anggotaDuacontroller.text,
                                      if (anggotaTigacontroller.text.isNotEmpty)
                                        anggotaTigacontroller.text,
                                      if (anggotaEmpatcontroller
                                          .text.isNotEmpty)
                                        anggotaEmpatcontroller.text,
                                      if (anggotaLimacontroller.text.isNotEmpty)
                                        anggotaLimacontroller.text,
                                    ],
                                    campusName: namaKampuscontroller.text,
                                  ),
                                );
                          },
                          label: 'Daftar');
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
