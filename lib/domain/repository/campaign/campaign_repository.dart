import 'package:crowdfunding_flutter/common/error/failure.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/campaign_update/create_campaign_update_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_comment_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/create_campaign_reply_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/campaign/update_campaign_payload.dart';
import 'package:crowdfunding_flutter/data/network/payload/donation/create_campaign_donation_payload.dart';
import 'package:crowdfunding_flutter/data/network/response/donation/giftcard_donation_response.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_category.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_comment.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_donation.dart';
import 'package:crowdfunding_flutter/domain/model/campaign/campaign_update.dart';
import 'package:crowdfunding_flutter/domain/usecases/campaign/fetch_campaigns.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CampaignRepository {
  Future<Either<Failure, List<Campaign>>> getCampaigns(
      FetchCampaignsPayload payload);
  Future<Either<Failure, Campaign>> getCampaign(String campaignId);

  Future<Either<Failure, List<CampaignCategory>>> getCampaignCategories();

  Future<Either<Failure, CampaignSummary>> createCampaign(
    CreateCampaignPayload payload,
  );

  Future<Either<Failure, CampaignComment>> createCampaignComment(
    CreateCampaignCommentPayload payload,
  );

  Future<Either<Failure, CampaignComment>> createCampaignReply(
    CreateCampaignReplyPayload payload,
  );

  Future<Either<Failure, Campaign>> updateCampaign(
    UpdateCampaignPayload payload,
  );

  // Campaign update
  Future<Either<Failure, CampaignUpdate>> createCampaignUpdatePost(
    CreateCampaignUpdatePayload payload,
  );

  // Donation
  Future<Either<Failure, GiftCardDonationResponse>> createGiftCardDonation(CreateGiftCardDonationPayload payload);
}
