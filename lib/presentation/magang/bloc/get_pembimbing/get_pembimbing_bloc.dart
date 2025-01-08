import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_students/datasources/internship_remote_datasources.dart';
import 'package:komdigi_logbooks_students/models/pembimbing_response_model.dart';

part 'get_pembimbing_event.dart';
part 'get_pembimbing_state.dart';
part 'get_pembimbing_bloc.freezed.dart';

class GetPembimbingBloc extends Bloc<GetPembimbingEvent, GetPembimbingState> {
  final InternshipRemoteDatasources datasource;
  GetPembimbingBloc(this.datasource) : super(_Initial()) {
    on<_GetPembimbing>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getPembimbing();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r.data ?? [])),
      );
    });
  }
}
