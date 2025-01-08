import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_students/datasources/internship_remote_datasources.dart';
import 'package:komdigi_logbooks_students/models/internship_response_model.dart';

part 'get_internship_event.dart';
part 'get_internship_state.dart';
part 'get_internship_bloc.freezed.dart';

class GetInternshipBloc extends Bloc<GetInternshipEvent, GetInternshipState> {
  final InternshipRemoteDatasources datasource;
  GetInternshipBloc(this.datasource) : super(_Initial()) {
    on<_GetInternship>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.getInternship(event.id);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r.data ?? [])),
      );
    });
  }
}
