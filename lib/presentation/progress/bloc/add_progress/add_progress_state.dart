part of 'add_progress_bloc.dart';

@freezed
class AddProgressState with _$AddProgressState {
  const factory AddProgressState.initial() = _Initial;
  const factory AddProgressState.loading() = _Loading;
  const factory AddProgressState.success(Progress progress) = _Success;
  const factory AddProgressState.error(String message) = _Error;
}
