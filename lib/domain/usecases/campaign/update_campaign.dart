import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/update_campaign_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/src/either.dart';

class UpdateCampaign implements UseCase<Campaign, UpdateCampaignPayload> {
  final CampaignRepository campaignRepository;

  UpdateCampaign({required this.campaignRepository});

  @override
  Future<Either<Failure, Campaign>> call(UpdateCampaignPayload payload) async {
    return await campaignRepository.updateCampaign(payload);
  }
}
