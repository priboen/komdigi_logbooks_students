part of 'get_grades_bloc.dart';

@freezed
class GetGradesState with _$GetGradesState {
  const factory GetGradesState.initial() = _Initial;
  const factory GetGradesState.loading() = _Loading;
  const factory GetGradesState.loaded(Grade grades) = _Loaded;
  const factory GetGradesState.error(String message) = _Error;
}
