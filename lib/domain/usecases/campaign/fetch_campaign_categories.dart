import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/common/usecase/usecase.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/repository/campaign/campaign_repository.dart';
import 'package:fpdart/src/either.dart';

class FetchCampaignCategories implements UseCase<List<CampaignCategory>, NoPayload> {
  final CampaignRepository campaignRepository;

  const FetchCampaignCategories({required this.campaignRepository});

  @override
  Future<Either<Failure, List<CampaignCategory>>> call(NoPayload payload) async {
    return await campaignRepository.getCampaignCategories();
  }
}
