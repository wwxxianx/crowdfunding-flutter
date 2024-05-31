import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/get_users_payload.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchUsers implements UseCase<List<UserModel>, GetUsersPayload> {
  final UserRepository userRepository;

  FetchUsers({required this.userRepository});
  @override
  Future<Either<Failure, List<UserModel>>> call(GetUsersPayload payload) async {
    return await userRepository.getUsers(payload);
  }
}
