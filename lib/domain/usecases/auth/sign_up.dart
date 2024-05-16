import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class SignUp implements UseCase<UserModel, AuthPayload> {
  final AuthRepository authRepository;

  SignUp(this.authRepository);

  @override
  Future<Either<Failure, UserModel>> call(AuthPayload payload) async {
    return await authRepository.createUserWithEmailPassword(
      email: payload.email,
      password: payload.password,
    );
  }
}

class AuthPayload {
  final String email;
  final String password;

  const AuthPayload({
    required this.email,
    required this.password,
  });
}
