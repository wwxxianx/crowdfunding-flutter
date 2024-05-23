import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/favourite_campaign/favourite_campaign_payload.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateFavouriteCampaign
    implements UseCase<UserFavouriteCampaign, FavouriteCampaignPayload> {
  final UserRepository userRepository;

  CreateFavouriteCampaign({required this.userRepository});

  @override
  Future<Either<Failure, UserFavouriteCampaign>> call(
      FavouriteCampaignPayload payload) async {
    return await userRepository.createFavouriteCampaign(payload);
  }
}
