import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tugas_akhir_project/models/internal.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

abstract class InternalSettingsRepository {
  TaskEither<ApiError, Internal> fetchInternalInformation(Ref ref);
}