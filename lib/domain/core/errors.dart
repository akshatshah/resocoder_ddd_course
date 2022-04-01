import 'package:resocoder_ddd_course/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    return Error.safeToString(
        'Encountered A ValueFailure at an  unrecoverable point. Terminating. Failure was: $valueFailure');
  }
}

class NotAuthenticatedError extends Error {}
