import 'package:bloc_test/bloc_test.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/usecases/auth/sign_up.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_bloc.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_event.dart';
import 'package:crowdfunding_flutter/state_management/sign_up/sign_up_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockSignUpUseCase extends Mock implements SignUp {}

void main() {
  group('SignUpBloc', () {
    late UserModel user;
    late SignUp signUp;
    late SignUpBloc signUpBloc;

    setUp(() async {
      user = UserModel.sample;
      signUp = MockSignUpUseCase();
      signUpBloc = SignUpBloc(signUp: signUp);
      registerFallbackValue(UserModel.sample);
      registerFallbackValue(
          AuthPayload(email: user.email, password: 'password'));
      when(() => signUp.call(any())).thenAnswer(
        (invocation) async {
          return right(user);
        },
      );
    });

    test('initial state is correct', () {
      expect(signUpBloc.state, SignUpInitial());
    });

    group('sign up user', () {
      blocTest(
        'emit [loading, success] after sign user up',
        build: () => signUpBloc,
        act: (bloc) => bloc.add(
          OnSignUp(
            email: user.email,
            password: 'password',
            onSuccess: (user) {},
          ),
        ),
        expect: () => [SignUpLoading(), SignUpSuccess(user)],
      );
    });
  });
}
