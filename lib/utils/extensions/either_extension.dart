import 'package:fpdart/fpdart.dart';

extension EitherHelpers<L, R> on Either<L, R> {
  R? unwrapRight() {
    return toOption().toNullable();
  }
}
