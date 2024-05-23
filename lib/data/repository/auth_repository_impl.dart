import 'package:crowdfunding_flutter/common/error/exceptions.dart';
import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/repository/auth_repository.dart';
import 'package:crowdfunding_flutter/domain/service/auth_service.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;
  const AuthRepositoryImpl({
    required this.authService,
  });

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
  Future<Either<Failure, UserModel>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final user = await authService.loginWithEmailPassword(
          email: email, password: password);
      return right(user);
    } on ServerException catch (e) {
      var logger = Logger();
      logger.w('error: $e');
      return left(Failure(e.message));
    }
  }

  @override
  Future<void> signOut() {
    return authService.signOut();
  }
}
