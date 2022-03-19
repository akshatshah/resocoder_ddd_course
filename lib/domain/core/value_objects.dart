import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:resocoder_ddd_course/domain/core/errors.dart';
import 'package:resocoder_ddd_course/domain/core/failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();

  Either<ValueFailure<T>, T> get value;

  bool isValid() => value.isRight();

  @override
  String toString() => 'Value($value)';

  /// Throws  [UnexpectedValueError] containing the [ValueFailure]
  /// id = identity. same as writing (r) => r
  ///
  /// ```dart
  /// test.getOrCrash()
  /// ```
  T getOrCrash() {
    return value.fold((f) => throw UnexpectedValueError(f), (r) => r);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
