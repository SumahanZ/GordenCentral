import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tugas_akhir_project/models/account_request.dart';

abstract class InternalAccountRepository {
  TaskEither editInternalInformation(
      {required AccountRequest request, required Ref ref});
}
