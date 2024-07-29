import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCloseToTargetCampaigns
    implements UseCase<List<Campaign>, NoPayload> {
  final CampaignRepository campaignRepository;

  const FetchCloseToTargetCampaigns({required this.campaignRepository});

  @override
  Future<Either<Failure, List<Campaign>>> call(NoPayload payload) async {
    return await campaignRepository.getCloseToTargetCampaigns();
  }
}
