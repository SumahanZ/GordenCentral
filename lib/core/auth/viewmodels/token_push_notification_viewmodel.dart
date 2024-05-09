// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/token_push_notification_repository_impl.dart';
part 'token_push_notification_viewmodel.g.dart';

@riverpod
class TokenPushNotificationViewModel extends _$TokenPushNotificationViewModel {
  @override
  FutureOr<void> build() {}

  void updateDeviceToken({
    required String deviceToken,
  }) async {
    final pushNotificationRepository =
        ref.read(pushNotificationRepositoryProvider);
    state = const AsyncLoading<void>();
    final apiResult = await pushNotificationRepository
        .updateUserDeviceToken(ref: ref, deviceToken: deviceToken)
        .run();
    apiResult.match((l) => state = AsyncError(l, StackTrace.current), (r) {
      try {
        state = const AsyncData<void>(null);
      } catch (error) {
        if (kDebugMode) {
          print(error.toString());
        }
      }
    });
  }
}
