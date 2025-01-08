import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_students/core/components/buttons.dart';
import 'package:komdigi_logbooks_students/core/components/spaces.dart';
import 'package:komdigi_logbooks_students/core/constants/constants.dart';
import 'package:komdigi_logbooks_students/core/extensions/date_time_ext.dart';
import 'package:komdigi_logbooks_students/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_students/models/auth_response_model.dart';
import 'package:komdigi_logbooks_students/presentation/progress/bloc/get_progress/get_progress_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/progress/dialog/detail_progress_dialog.dart';

class ProgressDashboardPage extends StatefulWidget {
  const ProgressDashboardPage({super.key});

  @override
  State<ProgressDashboardPage> createState() => _ProgressDashboardPageState();
}

class _ProgressDashboardPageState extends State<ProgressDashboardPage> {
  User? user;

  Future<void> _loadUserData() async {
    final authData = await AuthLocalDatasource().getAuthData();
    if (authData != null) {
      setState(() {
        user = authData.user;
        print(user!.id);
      });
    }
    context
        .read<GetProgressBloc>()
        .add(GetProgressEvent.getProgress(internshipId: user!.id));
  }

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cek Progress'),
      ),
      body: BlocBuilder<GetProgressBloc, GetProgressState>(
        builder: (context, state) {
          return state.maybeWhen(
              orElse: () => const Center(
                    child: Text('Tidak ada data'),
                  ),
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              loaded: (progress) {
                if (progress.isEmpty) {
                  return const Center(
                    child: Text('Tidak ada data'),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: progress.length,
                  itemBuilder: (context, index) {
                    final prog = progress[index];
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: const Border(
                            bottom: BorderSide(
                              color: AppColors.gray2,
                              width: 1.0,
                            ),
                            top: BorderSide(
                              color: AppColors.gray2,
                              width: 1.0,
                            ),
                            left: BorderSide(
                              color: AppColors.gray2,
                              width: 1.0,
                            ),
                            right: BorderSide(
                              color: AppColors.gray2,
                              width: 1.0,
                            ),
                          ),
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  prog.internship!.project!.name ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Button.filled(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          DetailProgressDialog(
                                        namaProject:
                                            prog.internship!.project!.name ??
                                                '',
                                        pertemuanBimbingan: prog.meeting ?? '',
                                        tanggalBimbingan:
                                            prog.date!.toFormattedDate(),
                                        namaProgress: prog.name ?? '',
                                      ),
                                    );
                                  },
                                  label: 'Detail',
                                  width: 95,
                                  height: 35,
                                ),
                              ],
                            ),
                            const Divider(
                              color: AppColors.gray2,
                            ),
                            const SpaceHeight(16.0),
                            Text(
                              'Progress Anda',
                              style: TextStyle(color: AppColors.gray1),
                            ),
                            const SpaceHeight(8.0),
                            Row(
                              children: [
                                Text(prog.name ?? ''),
                                Spacer(),
                                Text(
                                  prog.date!.toFormattedDate(),
                                  style: TextStyle(color: AppColors.gray1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              });
        },
      ),
    );
  }
}
