import 'package:crowdfunding_flutter/domain/usecases/auth/sign_up.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_event.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUp _signUp;
  SignUpBloc({
    required SignUp signUp,
  })  : _signUp = signUp,
        super(SignUpInitial()) {
    on<SignUpEvent>(_onEvent);
  }

  Future<void> _onEvent(
    SignUpEvent event,
    Emitter<SignUpState> emit,
  ) async {
    return switch (event) {
      final OnSignUp e => _onSignUp(e, emit),
    };
  }

  Future<void> _onSignUp(
    OnSignUp event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading());
    final res = await _signUp(AuthPayload(
      email: event.email,
      password: event.password,
    ));
    res.fold(
      (failure) => emit(SignUpFailure(failure.errorMessage)),
      (user) {
        emit(SignUpSuccess(user));
        event.onSuccess(user);
      },
    );
  }
}
