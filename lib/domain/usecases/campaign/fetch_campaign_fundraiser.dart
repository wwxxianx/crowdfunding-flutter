import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_fundraiser.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/fpdart.dart';

class FetchCampaignFundraiser implements UseCase<CampaignFundraiser, String> {
  final CampaignRepository campaignRepository;

  const FetchCampaignFundraiser({required this.campaignRepository});

  @override
  Future<Either<Failure, CampaignFundraiser>> call(String campaignId) async {
    return campaignRepository.getCampaignFundraiser(campaignId);
  }
}