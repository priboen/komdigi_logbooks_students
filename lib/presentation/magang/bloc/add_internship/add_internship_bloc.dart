import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_students/datasources/internship_remote_datasources.dart';
import 'package:komdigi_logbooks_students/models/add_internship_model.dart';

part 'add_internship_event.dart';
part 'add_internship_state.dart';
part 'add_internship_bloc.freezed.dart';

class AddInternshipBloc extends Bloc<AddInternshipEvent, AddInternshipState> {
  final InternshipRemoteDatasources datasources;
  AddInternshipBloc(this.datasources) : super(_Initial()) {
    on<_AddInternship>((event, emit) async {
      emit(_Loading());
      final result = await datasources.addInternship(
        campusName: event.campusName,
        leaderEmail: event.emailLeader,
        projectId: event.projectId,
        supervisorId: event.supervisorId,
        letterFile: event.letterUrl,
        memberPhotoFile: event.memberPhotoUrl,
        memberEmails: event.memberEmails,
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
