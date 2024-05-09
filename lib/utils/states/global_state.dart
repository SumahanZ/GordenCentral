import 'package:freezed_annotation/freezed_annotation.dart';
part 'global_state.freezed.dart';

/// this is required by freezed/
@freezed
sealed class GlobalState with _$GlobalState {
  const factory GlobalState.uninitialized() = Uninitialized;
  const factory GlobalState.data(bool? value) = Data;
  const factory GlobalState.loading() = Loading;
  const factory GlobalState.error(Object error, StackTrace stackTrace) = Error;
}
