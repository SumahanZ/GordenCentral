// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/internal/internaltoko/repositories/implementations/internal_internaltoko_repository_impl.dart';
import 'package:tugas_akhir_project/utils/states/global_state.dart';
part 'internal_internaltoko_viewmodel.g.dart';

@riverpod
class InternalTokoViewModel extends _$InternalTokoViewModel {
  @override
  GlobalState build() {
    return const GlobalState.uninitialized();
  }

  Future<void> acceptJoinRequest({required int targetInternalId}) async {
    try {
      state = const GlobalState.loading();
      final task = await ref
          .read(internalTokoRepositoryProvider)
          .acceptJoinRequest(ref: ref, targetInternalId: targetInternalId)
          .run();
      task.match((l) {
        state = GlobalState.error(l, StackTrace.current);
      }, (r) async {
        state = const GlobalState.data(null);
      });
    } catch (error) {
      print(error.toString());
      state = GlobalState.error(error, StackTrace.current);
    }
  }

  Future<void> declineJoinRequest({required int targetInternalId}) async {
    try {
      state = const GlobalState.loading();
      final task = await ref
          .read(internalTokoRepositoryProvider)
          .declineJoinRequest(ref: ref, targetInternalId: targetInternalId)
          .run();
      task.match((l) {
        state = GlobalState.error(l, StackTrace.current);
      }, (r) async {
        state = const GlobalState.data(null);
      });
    } catch (error) {
      print(error.toString());
      state = GlobalState.error(error, StackTrace.current);
    }
  }

  Future<void> addInternalThroughUserCode(
      {required String targetUserCode}) async {
    try {
      state = const GlobalState.loading();
      final task = await ref
          .read(internalTokoRepositoryProvider)
          .addInternalThroughUserCode(ref: ref, targetUserCode: targetUserCode)
          .run();
      task.match((l) {
        state = GlobalState.error(l, StackTrace.current);
      }, (r) async {
        state = const GlobalState.data(null);
      });
    } catch (error) {
      print(error.toString());
      state = GlobalState.error(error, StackTrace.current);
    }
  }

  Future<void> joinInternalThroughInviteCode(
      {required String inviteCode}) async {
    try {
      state = const GlobalState.loading();
      final task = await ref
          .read(internalTokoRepositoryProvider)
          .joinInternalThroughInviteCode(ref: ref, inviteCode: inviteCode)
          .run();
      task.match((l) {
        state = GlobalState.error(l, StackTrace.current);
      }, (r) async {
        state = const GlobalState.data(null);
      });
    } catch (error) {
      print(error.toString());
      state = GlobalState.error(error, StackTrace.current);
    }
  }
}
