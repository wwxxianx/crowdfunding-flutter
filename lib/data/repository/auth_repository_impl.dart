import 'package:crowdfunding_flutter/common/error/exceptions.dart';
import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/domain/model/user.dart';
import 'package:crowdfunding_flutter/domain/repository/auth_repository.dart';
import 'package:crowdfunding_flutter/domain/service/auth_service.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;
  const AuthRepositoryImpl(this.authService);

  @override
  Future<Either<Failure, UserModel>> createUserWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await authService.createUserWithEmailPassword(
          email: email, password: password);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUser() async {
    final session = authService.currentUserSession;

    if (session == null) {
      return left(Failure("Not logged in"));
    }

    return right(UserModel(
        id: session.user.id, email: session.user.email ?? "", fullName: ""));
  }

  @override
  Future<Either<Failure, UserModel>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await authService.loginWithEmailPassword(
          email: email, password: password);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<void> signOut() {
    return authService.signOut();
  }
}
