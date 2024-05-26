import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/campaign_update/create_campaign_update_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateCampaignUpdate
    implements UseCase<CampaignUpdate, CreateCampaignUpdatePayload> {
  final CampaignRepository campaignRepository;

  CreateCampaignUpdate({required this.campaignRepository});
  @override
  Future<Either<Failure, CampaignUpdate>> call(
      CreateCampaignUpdatePayload payload) async {
    return await campaignRepository.createCampaignUpdatePost(payload);
  }
}
