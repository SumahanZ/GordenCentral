import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class BrowseTokoRepository<R, T> {
  TaskEither<R, T> fetchTokos({required Ref ref});
}
