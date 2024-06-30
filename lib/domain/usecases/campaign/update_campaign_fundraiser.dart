import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/update_campaign_fundraiser_payload.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_fundraiser.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/src/either.dart';

class UpdateCampaignFundraiser
    implements UseCase<CampaignFundraiser, UpdateCampaignFundraiserPaylaod> {
  final CampaignRepository campaignRepository;

  UpdateCampaignFundraiser({
    required this.campaignRepository,
  });

  @override
  Future<Either<Failure, CampaignFundraiser>> call(
      UpdateCampaignFundraiserPaylaod payload) async {
    return await campaignRepository.updateCampaignFundraiser(payload);
  }
}
