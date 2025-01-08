import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_students/datasources/grade_remote_datasources.dart';
import 'package:komdigi_logbooks_students/models/grade_response_model.dart';

part 'get_grades_event.dart';
part 'get_grades_state.dart';
part 'get_grades_bloc.freezed.dart';

class GetGradesBloc extends Bloc<GetGradesEvent, GetGradesState> {
  final GradeRemoteDatasources datasources;
  GetGradesBloc(this.datasources) : super(_Initial()) {
    on<_GetGrades>((event, emit) async {
      emit(_Loading());
      final result = await datasources.getGrade(event.internshipId);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r.data!)),
      );
    });
  }
}
