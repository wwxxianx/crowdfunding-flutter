import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/user/favourite_campaign/favourite_campaign_payload.dart';
import 'package:crowdfunding_flutter/domain/repository/user/user_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeleteFavouriteCampaign
    implements UseCase<Unit, FavouriteCampaignPayload> {
  final UserRepository userRepository;

  DeleteFavouriteCampaign({required this.userRepository});

  @override
  Future<Either<Failure, Unit>> call(FavouriteCampaignPayload payload) async {
    return await userRepository.deleteFavouriteCampaign(payload);
  }
}
