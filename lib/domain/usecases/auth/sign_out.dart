import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class SignOut implements UseCase<void, NoPayload> {
  final AuthRepository authRepository;

  SignOut(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoPayload payload) async {
    await authRepository.signOut();
    return right(null);
  }
}
