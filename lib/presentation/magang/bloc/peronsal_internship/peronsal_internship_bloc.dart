import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_students/datasources/internship_remote_datasources.dart';
import 'package:komdigi_logbooks_students/models/personal_internship_response_model.dart';

part 'peronsal_internship_event.dart';
part 'peronsal_internship_state.dart';
part 'peronsal_internship_bloc.freezed.dart';

class PeronsalInternshipBloc
    extends Bloc<PeronsalInternshipEvent, PeronsalInternshipState> {
  final InternshipRemoteDatasources datasources;
  PeronsalInternshipBloc(this.datasources) : super(_Initial()) {
    on<_AddPersonalInternship>((event, emit) async {
      emit(_Loading());
      final result = await datasources.personalInternship(
        email: event.emailLeader,
        campus: event.campusName,
        projectId: event.projectId,
        supervisorId: event.supervisorId,
        letterFile: event.letterUrl,
        memberPhotoFile: event.memberPhotoUrl,
        startDate: event.startDate,
        endDate: event.endDate,
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
