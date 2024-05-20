import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/user_profile_payload.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserModel>> updateUserProfile(
    UserProfilePayload payload,
  );

  Future<Either<Failure, UserModel>> getUserProfile();
}
