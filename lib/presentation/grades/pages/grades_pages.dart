import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:komdigi_logbooks_students/presentation/grades/bloc/get_grades/get_grades_bloc.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_students/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_students/models/auth_response_model.dart';
import 'package:komdigi_logbooks_students/presentation/magang/bloc/get_internship/get_internship_bloc.dart';

class GradesPages extends StatefulWidget {
  const GradesPages({super.key});

  @override
  State<GradesPages> createState() => _GradesPagesState();
}

class _GradesPagesState extends State<GradesPages> {
  User? user;
  int? internshipId;
  String? gradeUrl;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Nilai'),
      ),
      body: BlocListener<GetInternshipBloc, GetInternshipState>(
        listener: (context, state) {
          state.maybeWhen(
            orElse: () {},
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (message) {
              Center(
                child: Text(message),
              );
            },
            success: (internships) {
              setState(() {
                internshipId = internships[0].id;
                print('Id Magang : $internshipId');
              });
              context
                  .read<GetGradesBloc>()
                  .add(GetGradesEvent.getGrades(internshipId: internshipId));
            },
          );
        },
        child: BlocBuilder<GetGradesBloc, GetGradesState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const Center(
                child: CircularProgressIndicator(),
              ),
              loading: () {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (message) {
                return Center(
                  child: Text(message),
                );
              },
              loaded: (grades) {
                final gradeUrl = grades.gradeUrl;
                return SfPdfViewer.network(
                  gradeUrl ?? '',
                  onDocumentLoaded: (details) {
                    print("PDF Loaded Successfully");
                  },
                  onDocumentLoadFailed: (details) {
                    print("Failed to load PDF: ${details.description}");
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
