import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchFavouriteCampaigns implements UseCase<List<UserFavouriteCampaign>, NoPayload> {
  final UserRepository userRepository;

  FetchFavouriteCampaigns({required this.userRepository});

  @override
  Future<Either<Failure, List<UserFavouriteCampaign>>> call(NoPayload payload) async {
    return await userRepository.getFavouriteCampaigns();
  }
}
