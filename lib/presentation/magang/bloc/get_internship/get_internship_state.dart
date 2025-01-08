part of 'get_internship_bloc.dart';

@freezed
class GetInternshipState with _$GetInternshipState {
  const factory GetInternshipState.initial() = _Initial;
  const factory GetInternshipState.loading() = _Loading;
  const factory GetInternshipState.success(List<Internship> internships) = _Success;
  const factory GetInternshipState.error(String message) = _Error;
}
