part of 'get_grades_bloc.dart';

@freezed
class GetGradesEvent with _$GetGradesEvent {
  const factory GetGradesEvent.started() = _Started;
  const factory GetGradesEvent.getGrades({required int? internshipId}) = _GetGrades;
}