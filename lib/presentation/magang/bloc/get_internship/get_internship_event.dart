part of 'get_internship_bloc.dart';

@freezed
class GetInternshipEvent with _$GetInternshipEvent {
  const factory GetInternshipEvent.started() = _Started;
  const factory GetInternshipEvent.getInternship({
    required int? id,
  }) = _GetInternship;
}