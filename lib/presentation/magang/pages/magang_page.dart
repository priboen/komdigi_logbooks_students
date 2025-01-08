import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:komdigi_logbooks_students/core/core.dart';
import 'package:komdigi_logbooks_students/core/extensions/extensions.dart';
import 'package:komdigi_logbooks_students/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_students/models/auth_response_model.dart';
import 'package:komdigi_logbooks_students/presentation/magang/bloc/get_internship/get_internship_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/magang/pages/register_magang_page.dart';

class MagangPage extends StatefulWidget {
  const MagangPage({super.key});

  @override
  State<MagangPage> createState() => _MagangPageState();
}

class _MagangPageState extends State<MagangPage> {
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
        .read<GetInternshipBloc>()
        .add(GetInternshipEvent.getInternship(id: user?.id));
  }

  @override
  void initState() {
    // _loadUserData();
    initializeDateFormatting('id_ID', null).then((_) {
      _loadUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Magang'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<GetInternshipBloc, GetInternshipState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () {
                    return Center(
                      child: Column(
                        children: [
                          Text('Belum ada data magang'),
                          const SpaceHeight(32.0),
                          Button.filled(
                              onPressed: () {
                                context.push(RegisterMagangPage());
                              },
                              label: 'Daftar Sekarang'),
                        ],
                      ),
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  success: (internships) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: internships.length,
                      itemBuilder: (context, index) {
                        final intern = internships[index];
                        String status = intern.status != null
                            ? intern.status!.replaceRange(
                                0, 1, intern.status![0].toUpperCase())
                            : 'Tidak ada status';
                        if (intern.status?.toLowerCase() == 'approved') {
                          status = 'Diterima';
                        } else {
                          status = 'Diproses';
                        }
                        return Container(
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
                                    intern.project?.name ?? 'Tidak ada nama',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  if (intern.status?.toLowerCase() !=
                                      'approved')
                                    Chip(
                                      backgroundColor: AppColors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                      side: const BorderSide(
                                        color: AppColors.black,
                                        width: 1.0,
                                      ),
                                      label: const Text(
                                        'Cancel',
                                      ),
                                      labelStyle: const TextStyle(
                                        color: AppColors.white,
                                      ),
                                    ),
                                ],
                              ),
                              const Divider(
                                color: AppColors.gray2,
                              ),
                              const SpaceHeight(16.0),
                              const Text(
                                'Status',
                                style: TextStyle(color: AppColors.gray1),
                              ),
                              const SpaceHeight(8.0),
                              Row(
                                children: [
                                  Chip(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                    side: const BorderSide(
                                      color: AppColors.primary,
                                      width: 1.0,
                                    ),
                                    label: Text(
                                      status,
                                    ),
                                    labelStyle: const TextStyle(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    intern.createdAt != null
                                        ? DateFormat(
                                                'EEEE, d MMMM yyyy', 'id_ID')
                                            .format(intern.createdAt!)
                                        : 'Tidak ada tanggal',
                                    style: TextStyle(color: AppColors.gray1),
                                  ),
                                ],
                              ),
                              const SpaceHeight(32.0),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
