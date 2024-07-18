import 'package:bloc_test/bloc_test.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/login.dart';
import 'package:crowdfunding_flutter/state_management/login/login_bloc.dart';
import 'package:crowdfunding_flutter/state_management/login/login_event.dart';
import 'package:crowdfunding_flutter/state_management/login/login_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements Login {}

void main() {
  group('LoginBloc', () {
    late UserModel user;
    late Login login;
    late LoginBloc loginBloc;

    setUp(() async {
      user = UserModel.sample;
      login = MockLoginUseCase();
      loginBloc = LoginBloc(login: login);
      registerFallbackValue(UserModel.sample);
      registerFallbackValue(
          LoginPayload(email: user.email, password: 'password'));
      when(() => login.call(any())).thenAnswer(
        (invocation) async {
          return right(user);
        },
      );
    });

    test('initial state is correct', () {
      expect(loginBloc.state, LoginInitial());
    });

    group('sign in user', () {
      blocTest(
        'emit [loading, success] after sign user in',
        build: () => loginBloc,
        act: (bloc) => bloc.add(
          OnLogin(
            email: user.email,
            password: 'password',
            onSuccess: (user) {},
          ),
        ),
        expect: () => [LoginLoading(), LoginSuccess(user)],
      );
    });
  });
}
