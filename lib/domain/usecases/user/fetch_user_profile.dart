import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchUserProfile implements UseCase<UserModel, NoPayload> {
  final UserRepository userRepository;

  const FetchUserProfile({required this.userRepository});

  @override
  Future<Either<Failure, UserModel>> call(NoPayload payload) async {
    return await userRepository.getCurrentUserProfile();
  }
}
