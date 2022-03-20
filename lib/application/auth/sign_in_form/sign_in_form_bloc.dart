import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:resocoder_ddd_course/domain/auth/i_auth_facade.dart';
import 'package:resocoder_ddd_course/domain/auth/value_objects.dart';
import 'package:resocoder_ddd_course/domain/auth/auth_failure.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;
  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<PasswordChanged>(
      (event, emit) => emit(
        state.copyWith(
          password: Password(event.passwordStr),
          authFailureOrSuccessOption: none(),
        ),
      ),
    );

    on<EmailChanged>(
      (event, emit) => emit(
        state.copyWith(
          emailAddress: EmailAddress(event.emailStr),
          authFailureOrSuccessOption: none(),
        ),
      ),
    );

    on<RegisterWithEmailAndPasswordPressed>(
      (event, emit) => _performActionOnAuthFacadeWithEmailAndPassword(
        emit: emit,
        forwardedCall: _authFacade.registerWithEmailAndPassword,
      ),
    );

    on<SignInWithEmailAndPasswordPressed>(
      (event, emit) => _performActionOnAuthFacadeWithEmailAndPassword(
        emit: emit,
        forwardedCall: _authFacade.signInWithEmailAndPassword,
      ),
    );

    on<SignInGooglePressed>(
      (event, emit) async {
        emit(
          state.copyWith(
            isSubmitting: true,
            authFailureOrSuccessOption: const None(),
          ),
        );
        final failureOrSuccess = await _authFacade.signInWithGoogle();
        emit(
          state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: Some(failureOrSuccess),
          ),
        );
      },
    );
  }

  void _performActionOnAuthFacadeWithEmailAndPassword({
    required Emitter<SignInFormState> emit,
    required Future<Either<AuthFailure, Unit>> Function(
            {required EmailAddress emailAddress, required Password password})
        forwardedCall,
  }) async {
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    Either<AuthFailure, Unit>? failureOrSuccess;

    ///Checking if value is valid
    if (isEmailValid && isPasswordValid) {
      emit(
        state.copyWith(
          isSubmitting: true,
          authFailureOrSuccessOption: none(),
        ),
      );

      failureOrSuccess = await forwardedCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }
    emit(
      state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption: optionOf(failureOrSuccess),
      ),
    );
  }
}
