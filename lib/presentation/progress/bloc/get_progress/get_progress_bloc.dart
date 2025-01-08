import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_students/datasources/progress_remote_datasources.dart';
import 'package:komdigi_logbooks_students/models/user_progress_response_model.dart';

part 'get_progress_event.dart';
part 'get_progress_state.dart';
part 'get_progress_bloc.freezed.dart';

class GetProgressBloc extends Bloc<GetProgressEvent, GetProgressState> {
  final ProgressRemoteDatasources datasource;
  GetProgressBloc(this.datasource) : super(_Initial()) {
    on<_GetProgress>((event, emit) async {
      emit(const _Loading());
      final result =
          await datasource.getProgress(event.internshipId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data ?? [])),
      );
    });
  }
}
