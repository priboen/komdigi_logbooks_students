part of 'peronsal_internship_bloc.dart';

@freezed
class PeronsalInternshipState with _$PeronsalInternshipState {
  const factory PeronsalInternshipState.initial() = _Initial;
  const factory PeronsalInternshipState.loading() = _Loading;
  const factory PeronsalInternshipState.success(PersonalInternshipResponseModel internships) = _Success;
  const factory PeronsalInternshipState.error(String message) = _Error;
}
