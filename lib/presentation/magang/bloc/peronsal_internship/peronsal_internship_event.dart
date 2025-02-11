part of 'peronsal_internship_bloc.dart';

@freezed
class PeronsalInternshipEvent with _$PeronsalInternshipEvent {
  const factory PeronsalInternshipEvent.started() = _Started;
  const factory PeronsalInternshipEvent.addPersonalInternship({
    required String emailLeader,
    required String campusName,
    required String startDate,
    required String endDate,
    required int? projectId,
    required int? supervisorId,
    required File letterUrl,
    required File memberPhotoUrl,
  }) = _AddPersonalInternship;
}