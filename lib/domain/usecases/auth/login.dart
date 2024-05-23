import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class LoginPayload {
  final String email;
  final String password;
  const LoginPayload({required this.email, required this.password});
}

class Login implements UseCase<UserModel, LoginPayload> {
  final AuthRepository authRepository;

  Login({required this.authRepository});

  @override
  Future<Either<Failure, UserModel>> call(LoginPayload payload) async {
    return await authRepository.loginWithEmailPassword(
        email: payload.email, password: payload.password);
  }
}
