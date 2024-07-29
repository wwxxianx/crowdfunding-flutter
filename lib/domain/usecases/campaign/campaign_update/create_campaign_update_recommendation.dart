import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/campaign_update/campaign_update_recommendation_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update_recommendation.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateCampaignUpdateRecommendation
    implements
        UseCase<CampaignUpdateRecommendation,
            CampaignUpdateRecommendationPayload> {
  final CampaignRepository campaignRepository;

  const CreateCampaignUpdateRecommendation({required this.campaignRepository});

  @override
  Future<Either<Failure, CampaignUpdateRecommendation>> call(
      CampaignUpdateRecommendationPayload payload) async {
    return await campaignRepository
        .createCampaignUpdatePostRecommendation(payload);
  }
}
