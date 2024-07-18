import 'package:crowdfunding_flutter/domain/usecases/auth/login.dart';
import 'package:crowdfunding_flutter/state_management/login/login_event.dart';
import 'package:crowdfunding_flutter/state_management/login/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login _login;
  LoginBloc({
    required Login login,
  })  : _login = login,
        super(LoginInitial()) {
    on<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent(
    LoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    return switch (event) {
      final OnLogin e => _onLogin(e, emit),
    };
  }

  Future<void> _onLogin(
    OnLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    final res = await _login(LoginPayload(
      email: event.email,
      password: event.password,
    ));
    res.fold(
      (failure) {
        emit(LoginFailure(failure.errorMessage));
      },
      (user) {
        emit(LoginSuccess(user));
        event.onSuccess(user);
      },
    );
  }
}
