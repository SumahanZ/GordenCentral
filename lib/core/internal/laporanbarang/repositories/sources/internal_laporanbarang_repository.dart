import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class InternalLaporanBarangRepository<R, T> {
  TaskEither<R, T> fetchLaporanBarangMasuk({required Ref ref});
  TaskEither<R, T> fetchLaporanBarangKeluar({required Ref ref});
  TaskEither<R, T> fetchLaporanGeneralInformation({required Ref ref});
}