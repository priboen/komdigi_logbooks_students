import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:komdigi_logbooks_students/core/constants/colors.dart';
import 'package:komdigi_logbooks_students/datasources/auth_remote_datasource.dart';
import 'package:komdigi_logbooks_students/datasources/grade_remote_datasources.dart';
import 'package:komdigi_logbooks_students/datasources/internship_remote_datasources.dart';
import 'package:komdigi_logbooks_students/datasources/progress_remote_datasources.dart';
import 'package:komdigi_logbooks_students/datasources/project_remote_datasources.dart';
import 'package:komdigi_logbooks_students/presentation/auth/bloc/login_bloc/login_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/auth/bloc/logout_bloc/logout_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/auth/pages/login_page.dart';
import 'package:komdigi_logbooks_students/presentation/grades/bloc/get_grades/get_grades_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/magang/bloc/add_internship/add_internship_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/magang/bloc/get_internship/get_internship_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/magang/bloc/get_pembimbing/get_pembimbing_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/profile/bloc/update_profile_bloc/update_profile_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/progress/bloc/add_progress/add_progress_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/progress/bloc/get_progress/get_progress_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/project/bloc/get_project/get_project_bloc.dart';
import 'package:komdigi_logbooks_students/presentation/register/bloc/register/register_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => GetProjectBloc(ProjectRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => GetInternshipBloc(InternshipRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => GetPembimbingBloc(InternshipRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => AddInternshipBloc(InternshipRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => AddProgressBloc(ProgressRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => GetProgressBloc(ProgressRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => GetGradesBloc(GradeRemoteDatasources()),
        ),
        BlocProvider(
          create: (context) => UpdateProfileBloc(AuthRemoteDatasource()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          dividerTheme:
              DividerThemeData(color: AppColors.primary.withAlpha(128)),
          dialogTheme: const DialogTheme(elevation: 0),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: AppColors.white),
            centerTitle: true,
            color: AppColors.primary,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: AppColors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}
