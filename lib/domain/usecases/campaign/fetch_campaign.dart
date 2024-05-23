import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCampaign implements UseCase<Campaign, String> {
  final CampaignRepository campaignRepository;

  FetchCampaign({required this.campaignRepository});

  @override
  Future<Either<Failure, Campaign>> call(String payload) async {
    return await campaignRepository.getCampaign(payload);
  }
}
