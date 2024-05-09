import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class InternalTokoRepository<R, T> {
  TaskEither<R, T> fetchInternals({required Ref ref});
  TaskEither<R, T> acceptJoinRequest(
      {required Ref ref, required int targetInternalId});
  TaskEither<R, T> declineJoinRequest(
      {required Ref ref, required int targetInternalId});
  TaskEither<R, T> addInternalThroughUserCode(
      {required Ref ref, required String targetUserCode});
  TaskEither<R, T> joinInternalThroughInviteCode(
      {required Ref ref, required String inviteCode});
}
