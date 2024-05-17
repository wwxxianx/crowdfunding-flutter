import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CampaignRepository {
  Future<Either<Failure, List<Campaign>>> getCampaigns();

  Future<Either<Failure, List<CampaignCategory>>> getCampaignCategories();
}
