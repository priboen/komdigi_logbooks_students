part of 'delete_internship_bloc.dart';

@freezed
class DeleteInternshipState with _$DeleteInternshipState {
  const factory DeleteInternshipState.initial() = _Initial;
  const factory DeleteInternshipState.loading() = _Loading;
  const factory DeleteInternshipState.success() = _Success;
  const factory DeleteInternshipState.error(String message) = _Error;
}
