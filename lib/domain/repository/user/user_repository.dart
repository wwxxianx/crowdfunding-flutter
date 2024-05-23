import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/favourite_campaign/favourite_campaign_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/user_profile_payload.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserModel>> updateUserProfile(
    UserProfilePayload payload,
  );

  Future<Either<Failure, UserModel>> getUserProfile();

  Future<Either<Failure, List<UserFavouriteCampaign>>> getFavouriteCampaigns();

  Future<Either<Failure, UserFavouriteCampaign>> createFavouriteCampaign(
    FavouriteCampaignPayload payload,
  );

  Future<Either<Failure, Unit>> deleteFavouriteCampaign(
    FavouriteCampaignPayload payload,
  );
}
