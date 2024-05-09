import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';

abstract class CustomerSettingsRepository<R, T> {
  TaskEither<R, T> fetchCustomerInformation(Ref ref);
}