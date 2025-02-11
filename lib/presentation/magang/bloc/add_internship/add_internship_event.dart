part of 'add_internship_bloc.dart';

@freezed
class AddInternshipEvent with _$AddInternshipEvent {
  const factory AddInternshipEvent.started() = _Started;
  const factory AddInternshipEvent.addInternship({
    required String emailLeader,
    required String campusName,
    required List<String> memberEmails,
    required int? projectId,
    required int? supervisorId,
    required File letterUrl,
    required File memberPhotoUrl,
    required String startDate,
    required String endDate,
  }) = _AddInternship;
}