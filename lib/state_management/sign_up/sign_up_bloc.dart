import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/sign_out.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/sign_up.dart';
import 'package:crowdfunding_flutter/state_management/app_user_cubit.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_event.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUp _signUp;
  final SignOut _signOut;
  final AppUserCubit _appUserCubit;
  SignUpBloc({
    required SignUp signUp,
    required SignOut signOut,
    required AppUserCubit appUserCubit,
  })  : _signUp = signUp,
        _signOut = signOut,
        _appUserCubit = appUserCubit,
        super(SignUpInitial()) {
    on<SignUpEvent>((event, emit) => emit(SignUpInitial()));
    on<OnSignUp>(_onSignUp);
    on<OnSignOut>(_onSignOut);
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
      (l) => emit(SignUpFailure(l.errorMessage)),
      (r) => _emitSignUpSuccess(r, emit, event.onSuccess),
    );
  }

  void _onSignOut(
    OnSignOut event,
    Emitter<SignUpState> emit,
  ) async {
    await _signOut(NoPayload());
    _appUserCubit.updateUser(null);
  }

  void _emitSignUpSuccess(
    UserModel user,
    Emitter<SignUpState> emit,
    VoidCallback onSuccess,
  ) {
    _appUserCubit.updateUser(user);
    emit(SignUpSuccess(user));
    onSuccess();
  }
}
