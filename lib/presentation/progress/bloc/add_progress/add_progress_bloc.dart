import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_students/datasources/progress_remote_datasources.dart';
import 'package:komdigi_logbooks_students/models/progress_response_model.dart';

part 'add_progress_event.dart';
part 'add_progress_state.dart';
part 'add_progress_bloc.freezed.dart';

class AddProgressBloc extends Bloc<AddProgressEvent, AddProgressState> {
  final ProgressRemoteDatasources datasource;
  AddProgressBloc(this.datasource) : super(_Initial()) {
    on<_AddProgress>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.addProgress(
        name: event.progress,
        internshipId: event.internshipId,
        meeting: event.meeting,
        date: event.date,
        file: event.attachment,
      );
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
