part of 'add_progress_bloc.dart';

@freezed
class AddProgressEvent with _$AddProgressEvent {
  const factory AddProgressEvent.started() = _Started;
  const factory AddProgressEvent.addProgress({
    required int? internshipId,
    required String meeting,
    required String date,
    required String progress,
    File? attachment,
  }) = _AddProgress;
}