part of 'delete_internship_bloc.dart';

@freezed
class DeleteInternshipEvent with _$DeleteInternshipEvent {
  const factory DeleteInternshipEvent.started() = _Started;
  const factory DeleteInternshipEvent.deleteInternship(int id) = _DeleteInternship;
}