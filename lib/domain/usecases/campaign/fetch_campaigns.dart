import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/enum/campaign_enum.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCampaignsPayload {
  final String? userId;
  final List<String> categoryIds;
  final List<String> stateIds;
  final String? searchQuery;
  final bool? isPublished;
  final FundraiserIdentificationStatusEnum? identificationStatus;
  final bool isCompleted;

  const FetchCampaignsPayload({
    this.userId,
    this.categoryIds = const [],
    this.stateIds = const [],
    this.searchQuery,
    this.isPublished,
    this.identificationStatus,
    this.isCompleted = false,
  });
}

class FetchCampaigns implements UseCase<List<Campaign>, FetchCampaignsPayload> {
  final CampaignRepository campaignRepository;

  const FetchCampaigns({required this.campaignRepository});

  @override
  Future<Either<Failure, List<Campaign>>> call(
      FetchCampaignsPayload payload) async {
    if (payload.isCompleted) {
      return await campaignRepository.getSuccessfulCampaigns();
    }
    return await campaignRepository.getCampaigns(payload);
  }
}
