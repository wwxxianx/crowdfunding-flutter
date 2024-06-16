import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateCampaign implements UseCase<CampaignSummary, CreateCampaignPayload> {
  final CampaignRepository campaignRepository;

  CreateCampaign({required this.campaignRepository});

  @override
  Future<Either<Failure, CampaignSummary>> call(CreateCampaignPayload payload) async {
    return await campaignRepository.createCampaign(payload);
  }
}
