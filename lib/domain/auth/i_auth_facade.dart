import 'package:dartz/dartz.dart';
import 'package:resocoder_ddd_course/domain/auth/auth_failure.dart';
import 'package:resocoder_ddd_course/domain/auth/value_objects.dart';

/// Interface (No implementation present)

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();
}
