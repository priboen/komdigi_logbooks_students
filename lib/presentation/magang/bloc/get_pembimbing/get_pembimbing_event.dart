part of 'get_pembimbing_bloc.dart';

@freezed
class GetPembimbingEvent with _$GetPembimbingEvent {
  const factory GetPembimbingEvent.started() = _Started;
  const factory GetPembimbingEvent.getPembimbing() = _GetPembimbing;
}