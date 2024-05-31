import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/favourite_campaign/favourite_campaign_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/get_users_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/user_profile_payload.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/gift_cards_response.dart';
import 'package:crowdfunding_flutter/domain/model/gift_card/num_gift_card_response.dart';
import 'package:crowdfunding_flutter/domain/model/user/user.dart';
import 'package:crowdfunding_flutter/domain/model/user/user_favourite_campaign.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserModel>> updateUserProfile(
    UserProfilePayload payload,
  );

  Future<Either<Failure, UserModel>> getUserProfile();

  Future<Either<Failure, List<UserModel>>> getUsers(GetUsersPayload payload);

  Future<Either<Failure, List<UserFavouriteCampaign>>> getFavouriteCampaigns();

  Future<Either<Failure, UserFavouriteCampaign>> createFavouriteCampaign(
    FavouriteCampaignPayload payload,
  );

  Future<Either<Failure, Unit>> deleteFavouriteCampaign(
    FavouriteCampaignPayload payload,
  );

  Future<Either<Failure, NumOfGiftCardsResponse>>
      getNumOfReceivedUnusedGiftCards();

  Future<Either<Failure, GiftCardsResponse>> getAllGiftCards();
}
