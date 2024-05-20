import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/user_profile_payload.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class UpdateUserProfile implements UseCase<UserModel, UserProfilePayload> {
  final UserRepository userRepository;

  UpdateUserProfile({required this.userRepository});

  @override
  Future<Either<Failure, UserModel>> call(UserProfilePayload payload) async {
    return await userRepository.updateUserProfile(payload);
  }
}
