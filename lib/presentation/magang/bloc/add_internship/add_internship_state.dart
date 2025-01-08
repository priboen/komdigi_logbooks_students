part of 'add_internship_bloc.dart';

@freezed
class AddInternshipState with _$AddInternshipState {
  const factory AddInternshipState.initial() = _Initial;
  const factory AddInternshipState.loading() = _Loading;
  const factory AddInternshipState.success(AddInternshipResponseModel Internship) = _Success;
  const factory AddInternshipState.error(String message) = _Error;
}
